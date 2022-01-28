import * as Validator from 'class-validator';

export class UserRegistrationDto {
    @Validator.IsNotEmpty()
    @Validator.IsEmail({
        allow_ip_domain: false, // ne može pgale@127.0.0.1
        allow_utf8_local_part: true,
        require_tld: true,  // ovo ne može: pgala@localhost mora završavati sa .com ili slično
    })
    email: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(6, 128) // iako je ovdje definisano min 6 znakova "pita se" definicija u validaciji ispod
    @Validator.Matches(/^.{7,128}$/, {
        message: 'Lozinka mora biti najmanje 7 znakova dugačka'
    })
    password: string;

    
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2,64)
    forename: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2,64)
    surname: string;

    @Validator.IsNotEmpty()
    @Validator.IsPhoneNumber(null) // mora +38765 ...
    phoneNumber: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(10,512)
    postalAddress: string;
}