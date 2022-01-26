import { Body, Controller, Get, Param, Post, Put, UseGuards } from "@nestjs/common";
import { Administrator } from "src/entities/administrator.entity";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";

@Controller('api/administrator')
export class AdministratorController {
    constructor(
        private administratorService: AdministratorService
    ) {}

    @Get()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    getAll(): Promise<Administrator[]> {
    return this.administratorService.getAll();
    }

    @Get(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    getById(@Param('id') administratorId: number): Promise<Administrator | ApiResponse>
    {
        return new Promise(async (resolve) => {
            let admin = await this.administratorService.getById(administratorId);

            if (admin === undefined) {
                resolve(new ApiResponse("error", -1003));
            }

            resolve(admin);
        });
    }

    @Post()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    add(@Body() data: AddAdministratorDto): Promise<Administrator | ApiResponse> {
        return this.administratorService.add(data);
    }

    @Put(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    edit(@Param('id') id:number, @Body() data: EditAdministratorDto) : Promise<Administrator | ApiResponse> {
        return this.administratorService.editById(id, data);
    }



}