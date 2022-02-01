import { Body, Controller, HttpException, HttpStatus, Post, Req, UseGuards } from "@nestjs/common";
import { ApiProperty } from "@nestjsx/crud/lib/crud";
import { Request } from "express";
import { UserRefreshTokenDto } from "src/dtos/auth/user.refresh.token.dto";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { UserService } from "src/services/user/user.service";
import * as jwt from 'jsonwebtoken';
import { JwtRefreshDataDto } from "src/dtos/auth/jwt.refresh.dto";
import { jwtSecret } from "config/jwt.secret";
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import { LoginInfoDto } from "src/dtos/auth/login.info.dto";

@Controller('token')
export class TokenController {
    [x: string]: any;
    constructor(
        private administratorService: AdministratorService,
        private userService: UserService
    ) {}

    

    private getDatePlus(numbersOfSeconds: number): number {
        return new Date().getTime() / 1000 + numbersOfSeconds;
    }

    private getIsoDate(timestamp: number): string {
        const date = new Date();
        date.setTime(timestamp * 1000);
        return date.toISOString();
    }
}