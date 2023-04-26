// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_basket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductBasketAdapter extends TypeAdapter<ProductBasket> {
  @override
  final int typeId = 0;

  @override
  ProductBasket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductBasket(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductBasket obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.priceBeforDiscount)
      ..writeByte(4)
      ..write(obj.discount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductBasketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
