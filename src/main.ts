import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { StorageConfig } from 'config/storage.config';
import { AppModule } from './app.module';

async function bootstrap() {
  //mijenjamo vrstu aplikacije poslije cretae <>
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  // serviranje statički asseta za fotografije
  app.useStaticAssets(StorageConfig.photo.destination, {
    prefix: StorageConfig.photo.urlPrefix,
    maxAge: StorageConfig.photo.maxAge, // 7 dana smo ostavili da slika bude u kešu
    index: false,  // ne možemo listati sadržaj direktorijuma u kome su slike
  })
  await app.listen(3000);
}
bootstrap();
