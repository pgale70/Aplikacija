import {
  Column,
  Entity,
  Index,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Category } from "./category.entity";
import { ArticleFeature } from "./article-feature.entity";
import { ArticlePrice } from "./article-price.entity";
import { CartArticle } from "./cart-article.entity";
import { Photo } from "./photo.entity";
import { Feature } from "./feature.entity";
import * as Validator from 'class-validator';
// import { ArticleStatus } from "src/types/article.status.enum";

@Index("fk_article_category_id", ["categoryId"], {})
@Entity("article")
export class Article {
  @PrimaryGeneratedColumn({ type: "int", name: "article_id", unsigned: true })
  articleId: number;

  @Column( { type: "varchar", length: 128 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(5, 128)
  name: string;

  @Column( { type: "int", name: "category_id", unsigned: true })
  categoryId: number;

  @Column( { type:"varchar", length: 255 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(10, 255)
  excerpt: string;

  @Column( { type: "text" })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(64, 10000)
  description: string;

  @Column({
    type: "enum", 
    enum: ["available", "visible", "hidden"],
    default: () => "'available'",
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  // @Validator.IsEnum(ArticleStatus)  --- jedan način
  @Validator.IsIn(["available", "visible", "hidden"])  // --- drugi način
  status: "available" | "visible" | "hidden";

  @Column( { type: "tinyint", name: "is_promoted", width: 1, default: () => "'0'" })
  @Validator.IsNotEmpty()
  @Validator.IsIn([0, 1])
  isPromoted: number;

  @Column( {
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @ManyToOne(() => Category, (category) => category.articles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.article)
  articleFeatures: ArticleFeature[];

  // Ovo smo ručno dodali da bi umjesto šifre za osobinu vidjeli naziv te osobine
  //---------------------------
  @ManyToMany(type => Feature, feature => feature.articles)
  @JoinTable({
    name: "article_feature",
    joinColumn: {name: "article_id", referencedColumnName: "articleId"},
    inverseJoinColumn: {name: "feature_id", referencedColumnName: "featureId"}
  })
  features: Feature[];
  //------------------------------

  @OneToMany(() => ArticlePrice, (articlePrice) => articlePrice.article)
  articlePrices: ArticlePrice[];

  @OneToMany(() => CartArticle, (cartArticle) => cartArticle.article)
  cartArticles: CartArticle[];

  @OneToMany(() => Photo, (photo) => photo.article)
  photos: Photo[];
}
