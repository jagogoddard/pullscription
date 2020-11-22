from django.db import models

class Comic(models.Model): # Fields imported from left to right on the original .csv
    diamd_no = models.CharField(max_length=9) # Format: ???######
    stock_no = models.CharField(max_length=9) # Format: STL######
    parent_item_no_alt = models.CharField(max_length=9) # Format: MON######
    bounce_use_item = models.CharField(max_length=9) # Not used in current .csv
    full_title = models.CharField(max_length=60)
    main_desc = models.CharField(max_length=60)
    variant_desc = models.CharField(max_length=60)
    series_code = models.IntegerField()
    issue_no = models.IntegerField()
    issue_seq_no = models.IntegerField()
    volume_tag = models.CharField(max_length=9)
    max_issue = models.IntegerField()
    price = models.DecimalField(max_digits=10,decimal_places=2)
    publisher = models.CharField(max_length=9)
    upc_no = models.CharField(max_length=17)
    short_isbn_no = models.CharField(max_length=10)
    ean_no = models.CharField(max_length=18)
    cards_per_pack = models.IntegerField()
    pack_per_box = models.IntegerField()
    box_per_case = models.IntegerField()
    discount_code = models.CharField(max_length=2)
    increment = models.IntegerField()
    prnt_date = models.DateField()
    foc_vendor = models.CharField(max_length=1)
    ship_date = models.DateField()
    srp = models.DecimalField(max_digits=10,decimal_places=2)
    category = models.IntegerField()
    genre = models.CharField(max_length=2)
    brand_code = models.CharField(max_length=2)
    mature = models.CharField(max_length=1)
    adult = models.CharField(max_length=1)
    oa = models.CharField(max_length=1)
    caut1 = models.IntegerField()
    caut2 = models.IntegerField()
    caut3 = models.IntegerField()
    resol = models.CharField(max_length=1)
    note_price = models.CharField(max_length=1)
    order_form_notes = models.CharField(max_length=255)
    page = models.IntegerField()
    writer = models.CharField(max_length=255)
    artist = models.CharField(max_length=255)
    cover_artist = models.CharField(max_length=255)
    colorist = models.CharField(max_length=255)
    alliance_sku = models.CharField(max_length=255)
    foc_date = models.DateField()
    offered_date = models.DateField()
    number_of_pages = models.IntegerField()
    unit_weight = models.DecimalField(max_digits=10,decimal_places=2)
    unit_length = models.DecimalField(max_digits=10,decimal_places=2)
    unit_width = models.DecimalField(max_digits=10,decimal_places=2)
    unit_height = models.DecimalField(max_digits=10,decimal_places=2)
    case_weight = models.DecimalField(max_digits=10,decimal_places=2)
    case_length = models.DecimalField(max_digits=10,decimal_places=1)
    case_width = models.DecimalField(max_digits=10,decimal_places=1)
    case_height = models.DecimalField(max_digits=10,decimal_places=1)
    

def __str__(self):
    # We can actually make JSON generation really simple if we have the __str__ method to print out all of the attributes in comma separated format.
    # I'll get a concatenation working pretty soon - Satsuki
    return = "{" + "diamd_no:" + '"' + str(self.diamd_no) + '",' + "stock_no:" + '"' + str(self.stock_no) + '",' + "parent_item_no_alt:" + '"' + str(self.parent_item_no_alt) + '",' + "bounce_use_item:" + '"' + str(self.bounce_use_item) + '",' + "full_title:" + '"' + str(self.full_title) + '",' + "main_desc:" + '"' + str(self.main_desc) + '",' + "variant_desc:" + '"' + str(self.variant_desc) + '",' + "series_code:" + '"' + str(self.series_code) + '",' + "issue_no:" + '"' + str(self.issue_no) + '",' + "issue_seq_no:" + '"' + str(self.issue_seq_no) + '",' + "volume_tag:" + '"' + str(self.volume_tag) + '",' + "max_issue:" + '"' + str(self.max_issue) + '",' + "price:" + '"' + str(self.price) + '",' + "publisher:" + '"' + str(self.publisher) + '",' + "upc_no:" + '"' + str(self.upc_no) + '",' + "short_isbn_no:" + '"' + str(self.short_isbn_no) + '",' + "ean_no:" + '"' + str(self.ean_no) + '",' + "cards_per_pack:" + '"' + str(self.cards_per_pack) + '",' + "pack_per_box:" + '"' + str(self.pack_per_box) + '",' + "box_per_case:" + '"' + str(self.box_per_case) + '",' + "discount_code:" + '"' + str(self.discount_code) + '",' + "increment:" + '"' + str(self.increment) + '",' + "prnt_date:" + '"' + str(self.prnt_date) + '",' + "foc_vendor:" + '"' + str(self.foc_vendor) + '",' + "ship_date:" + '"' + str(self.ship_date) + '",' + "srp:" + '"' + str(self.srp) + '",' + "category:" + '"' + str(self.category) + '",' + "genre:" + '"' + str(self.genre) + '",' + "brand_code:" + '"' + str(self.brand_code) + '",' + "mature:" + '"' + str(self.mature) + '",' + "adult:" + '"' + str(self.adult) + '",' + "oa:" + '"' + str(self.oa) + '",' + "caut1:" + '"' + str(self.caut1) + '",' + "caut2:" + '"' + str(self.caut2) + '",' + "caut3:" + '"' + str(self.caut3) + '",' + "resol:" + '"' + str(self.resol) + '",' + "note_price:" + '"' + str(self.note_price) + '",' + "order_form_notes:" + '"' + str(self.order_form_notes) + '",' + "page:" + '"' + str(self.page) + '",' + "writer:" + '"' + str(self.writer) + '",' + "artist:" + '"' + str(self.artist) + '",' + "cover_artist:" + '"' + str(self.cover_artist) + '",' + "colorist:" + '"' + str(self.colorist) + '",' + "alliance_sku:" + '"' + str(self.alliance_sku) + '",' + "foc_date:" + '"' + str(self.foc_date) + '",' + "offered_date:" + '"' + str(self.offered_date) + '",' + "number_of_pages:" + '"' + str(self.number_of_pages) + '",' + "unit_weight:" + '"' + str(self.unit_weight) + '",' + "unit_length:" + '"' + str(self.unit_length) + '",' + "unit_width:" + '"' + str(self.unit_width) + '",' + "unit_height:" + '"' + str(self.unit_height) + '",' + "case_weight:" + '"' + str(self.case_weight) + '",' + "case_length:" + '"' + str(self.case_length) + '",' + "case_width:" + '"' + str(self.case_width) + '",' + "case_height:" + '"' + str(self.case_height) + '"}'