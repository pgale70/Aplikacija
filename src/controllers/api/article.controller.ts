import { Body, Controller, Param, Post, Req, UploadedFile, UseInterceptors } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { Crud } from "@nestjsx/crud";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ArticleService } from "src/services/article/article.service";
import { diskStorage } from "multer";
import { StorageConfig } from "config/storage.config";
import { PhotoService } from "src/services/photo/photo.service";
import { Photo } from "src/entities/photo.entity";
import { ApiResponse } from "src/misc/api.response.class";
import * as fileType from 'file-type';
// import { FileTypeResult } from "file-type/core.js";
import * as fs from 'fs';
import * as sharp from 'sharp';

@Controller('api/article')
@Crud({
    model: {
        type: Article
    },
    params: {
        id: {
            field: 'articleId',
            type: 'number',
            primary: true
        }
    },
    query: {
        join: {
            category: {
                eager: true
            },
            photos: {
                eager: true
            },
            articlePrices: {
                eager: true
            },
            articleFeatures: {
                eager: true
            },
            features: {
                eager: true
            }


            
        }
    }
})
export class ArticleController {
    constructor (
        public service: ArticleService,
        public photoService: PhotoService,
        ) {}

    @Post('createFull')
    createFullArticle(@Body() data: AddArticleDto) {
        return this.service.createFullArticle(data);
    }

    @Post(':id/uploadPhoto/')
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photo.destination,
                filename:  (req, file, callback) => {
                   
                    let original: string = file.originalname;

                    let normalized = original.replace(/\s+/g, '-');

                    //ako iz imena slike želimo da uklonimo sve što nisu mala i velika slova
                    // cifre od 0 do 9 znak . i - onda radimo sljedece
                    normalized=normalized.replace(/[^A-z0-9\.\-]/g, '');
                    let sada = new Date();
                    let datePart ='';
                    datePart += sada.getFullYear().toString();
                    datePart += (sada.getMonth()+1).toString();
                    datePart += sada.getDate().toString();

                    let niz10Elemenata = new Array(10);
                    niz10Elemenata.fill(0);
                    let randomPart: string =
                        new Array(10)
                            .fill(0)
                            .map(e => (Math.random() * 9).toFixed(0).toString())
                            .join('');

                    let fileName = datePart + '-' + randomPart + '-' + normalized;

                    fileName = fileName.toLocaleLowerCase();

                    callback(null, fileName);

                }
            }),
            fileFilter: (req, file, callback) => {
                // 1. provjera ekstenzije jpg png
                if(!file.originalname.toLowerCase().match(/\.(jpg|png)$/)) {
                    callback(new Error('Bad file extensions!'), false);
                    return;
                }

                // 2. provjera tipa sadrzaja: image/jpeg, image/png (mimetype)
                if(!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))) {
                callback(new Error('Bad file content!'), false);
                return;

            }

            callback(null, true);
        },
        limits: {
            files: 1,
            fieldSize: StorageConfig.photo.maxSize,
        }

        })
    )
    async uploadPhoto(
        @Param('id') articleId: number, 
        @UploadedFile() photo,
        @Req() req 
    ): Promise< ApiResponse | Photo > {
        
        if (req.fileFilterError) {
            return new ApiResponse('error', -4002, req.fileFilterError);
        }

        if(!photo) {
            return new ApiResponse('error', -4002, 'File not uploaded!');
        }

        
        // OVDJE KOD PRAVI PROBLEM
        const fileTypeResult = await fileType.fromFile(photo.path);
        if (!fileTypeResult) {
            // obrisati fajl
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Cannot detect file type!');
        }

        const realMimeType = fileTypeResult.mime;
        if(!(realMimeType.includes('jpeg') || realMimeType.includes('png'))) {
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Bad file content type!');
        }


        //let imagePath = photo.filename;  ne znam čemu ovo služi

        await this.createResizedImage(photo, StorageConfig.photo.resize.thumb);
        await this.createResizedImage(photo, StorageConfig.photo.resize.small);

        const newPhoto: Photo = new Photo();
        newPhoto.articleId = articleId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if(!savedPhoto) {
            return new ApiResponse('error', -4001);
        }

        return savedPhoto;
    }

    
    async createResizedImage(photo, resizeSettings) {
        const originalFilePath = photo.path;
        const fileName = photo.filename;

        const destinationFilePath = 
        StorageConfig.photo.destination + 
        resizeSettings.directory + 
        fileName;

        await sharp(originalFilePath)
            .resize({
                fit: 'cover',   
                width: resizeSettings.width,
                height: resizeSettings.height,
                
            })
            .toFile(destinationFilePath);
    }

} 