import {
  Column,
  Entity,
  Index,
  JoinColumn,
  OneToOne,
  PrimaryGeneratedColumn,
} from "typeorm";

@Index("uq_order_cart_id", ["cartId"], { unique: true })
@Entity("order", )
export class Order {
  @PrimaryGeneratedColumn({ type: "int", name: "order_id", unsigned: true })
  orderId: number;

  @Column( {
    type:"timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @Column( {
    type: "int",
    name: "cart_id",
    unique: true,
    unsigned: true
  })
  cartId: number;

  @Column( {
    type: "enum",
    name: "status",
    enum: ["rejected", "accepted", "shipped", "pending"],
    default: () => "'pending'",
  })
  status: "rejected" | "accepted" | "shipped" | "pending";

  @OneToOne(() => Order, (order) => order.order, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "cart_id", referencedColumnName: "orderId" }])
  cart: Order;

  @OneToOne(() => Order, (order) => order.cart)
  order: Order;
}