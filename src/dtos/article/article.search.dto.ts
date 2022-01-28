import * as Validator from 'class-validator';

export class ArticleSearchDto {
    @Validator.IsOptional()
    @Validator.IsString()
    @Validator.Length(2,128)
    keywords: string;

    @Validator.IsOptional()
    categorId: number;

    @Validator.IsOptional()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 2,
    })
    priceMin: number;

    @Validator.IsOptional()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 2,
    })
    priceMax: number;

    features: {
        featureId: number;
        values: string[];
    }[];

    orderBy: 'name' | 'price';
    orderDirection: 'asc' | 'des';
    itemsPerPage: 5 | 10 | 25 | 50 | 75;
}