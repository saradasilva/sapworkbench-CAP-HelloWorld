namespace my.bookshop;

using {Currency} from '@sap/cds/common';

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
        price : Decimal(10, 3);
        genre : Genre;
        author_ID: Integer;
        author_no: Association to Authors on author_no.ID = author_ID; //asociación no gestionada
        author_one: Association to Authors; //asociación M-1
        author_many: Association to many Authors on author_many.book = $self;
        bookCovers: Composition of many BookCovers on bookCovers.book = $self;
}

entity BookCovers {
    key ID: Integer;
    imageName: String;
    book: Association to Books;
}

entity Authors {
    key ID   : Integer;
        name : String;
        book: Association to Books;
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
        select from Products {
            ID,
            title
        }
        where
            Products.ID = 1;
}
