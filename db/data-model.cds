namespace my.bookshop;

using {Currency} from '@sap/cds/common';

type Prize {
    value    : Decimal(10, 3);
}

type Genre : Integer enum {
    Action    = 1;
    Comedy    = 2;
    Drama     = 3;
    Fantasy   = 4;
    Adventure = 5;
};

entity Books {
    key ID    : Integer;
        title : String;
        stock : Integer;
        price : Prize;
        genre : Genre
}

aspect managedBy {
    createdAt : Timestamp;
    createdBy : String
}

entity Products : managedBy {
    key ID    : Integer;
        title : String;
}

entity SalesInvoice : managedBy {
    
}

entity MoreProducts as projection on Products;

service ProductService {
    entity AllProducts as select from Products;

    entity OneProduct  as
        select from Products {ID, title}
        where
            Products.ID = 1;
}