from django.db import models

class Comic(models.Model): # Fields imported from left to right on the original .csv
    diamd_no = models.CharField(db_column='DIAMD_NO',max_length=9,primary_key=True) # Format: ???######
    stock_no = models.CharField(db_column='STOCK_NO',max_length=9) # Format: STL######
    parent_item_no_alt = models.CharField(db_column='PARENT_ITEM_NO_ALT',max_length=9,blank=True,null=True) # Format: MON######
    bounce_use_item = models.CharField(db_column='BOUNCE_USE_ITEM',max_length=9,blank=True,null=True) # Not used in current .csv
    full_title = models.CharField(db_column='FULL_TITLE',max_length=60)
    main_desc = models.CharField(db_column='MAIN_DESC',max_length=60)
    variant_desc = models.CharField(db_column='VARIANT_DESC',max_length=60,blank=True,null=True)
    series_code = models.IntegerField(db_column='SERIES_CODE')
    issue_no = models.IntegerField(db_column='ISSUE_NO',blank=True,null=True)
    issue_seq_no = models.IntegerField(db_column='ISSUE_SEQ_NO')
    volume_tag = models.CharField(db_column='VOLUME_TAG',max_length=9,blank=True,null=True)
    max_issue = models.IntegerField(db_column='MAX_ISSUE',blank=True,null=True)
    price = models.DecimalField(db_column='PRICE',max_digits=10,decimal_places=2)
    publisher = models.CharField(db_column='PUBLISHER',max_length=9)
    upc_no = models.CharField(db_column='UPC_NO',max_length=17,blank=True,null=True)
    short_isbn_no = models.CharField(db_column='SHORT_ISBN_NO',max_length=10,blank=True,null=True)
    ean_no = models.CharField(db_column='EAN_NO',max_length=18,blank=True,null=True)
    cards_per_pack = models.IntegerField(db_column='CARDS_PER_PACK')
    pack_per_box = models.IntegerField(db_column='PACK_PER_BOX')
    box_per_case = models.IntegerField(db_column='BOX_PER_CASE')
    discount_code = models.CharField(db_column='DISCOUNT_CODE',max_length=2)
    increment = models.IntegerField(db_column='INCREMENT')
    prnt_date = models.DateField(db_column='PRNT_DATE')
    foc_vendor = models.CharField(db_column='FOC_VENDOR',max_length=1)
    ship_date = models.TextField(db_column='SHIP_DATE')
    srp = models.DecimalField(db_column='SRP',max_digits=10,decimal_places=2)
    category = models.IntegerField(db_column='CATEGORY')
    genre = models.CharField(db_column='GENRE',max_length=2,blank=True,null=True)
    brand_code = models.CharField(db_column='BRAND_CODE',max_length=2,blank=True,null=True)
    mature = models.CharField(db_column='MATURE',max_length=1)
    adult = models.CharField(db_column='ADULT',max_length=1)
    oa = models.CharField(db_column='OA',max_length=1)
    caut1 = models.IntegerField(db_column='CAUT1')
    caut2 = models.IntegerField(db_column='CAUT2')
    caut3 = models.IntegerField(db_column='CAUT3')
    resol = models.CharField(db_column='RESOL',max_length=1)
    note_price = models.CharField(db_column='NOTE_PRICE',max_length=1)
    order_form_notes = models.CharField(db_column='ORDER_FORM_NOTES',max_length=255,blank=True,null=True)
    page = models.IntegerField(db_column='PAGE')
    writer = models.CharField(db_column='WRITER',max_length=255,blank=True,null=True)
    artist = models.CharField(db_column='ARTIST',max_length=255,blank=True,null=True)
    cover_artist = models.CharField(db_column='COVER_ARTIST',max_length=255,blank=True,null=True)
    colorist = models.CharField(db_column='COLORIST',max_length=255,blank=True,null=True)
    alliance_sku = models.CharField(db_column='ALLIANCE_SKU',max_length=255,blank=True,null=True)
    foc_date = models.DateField(db_column='FOC_DATE',blank=True,null=True)
    offered_date = models.DateField(db_column='OFFERED_DATE',blank=True,null=True)
    number_of_pages = models.IntegerField(db_column='NUMBER_OF_PAGES')
    unit_weight = models.DecimalField(db_column='UNIT_WEIGHT',max_digits=10,decimal_places=2)
    unit_length = models.DecimalField(db_column='UNIT_LENGTH',max_digits=10,decimal_places=2)
    unit_width = models.DecimalField(db_column='UNIT_WIDTH',max_digits=10,decimal_places=2)
    unit_height = models.DecimalField(db_column='UNIT_HEIGHT',max_digits=10,decimal_places=2)
    case_weight = models.DecimalField(db_column='CASE_WEIGHT',max_digits=10,decimal_places=2)
    case_length = models.DecimalField(db_column='CASE_LENGTH',max_digits=10,decimal_places=1)
    case_width = models.DecimalField(db_column='CASE_WIDTH',max_digits=10,decimal_places=1)
    case_height = models.DecimalField(db_column='CASE_HEIGHT',max_digits=10,decimal_places=1)

    class Meta:
        managed = False
        db_table = 'masterData'
        
    def __str__(self):
        # Concatenates all fields in a JSON format, making outputting easier in the views.
        return "{" + '"diamd_no":' + '"' + str(self.diamd_no) + '",' + '"stock_no":' + '"' + str(self.stock_no) + '",' + '"parent_item_no_alt":' + '"' + str(self.parent_item_no_alt) + '",' + '"bounce_use_item":' + '"' + str(self.bounce_use_item) + '",' + '"full_title":' + '"' + str(self.full_title) + '",' + '"main_desc":' + '"' + str(self.main_desc) + '",' + '"variant_desc":' + '"' + str(self.variant_desc) + '",' + '"series_code":' + '"' + str(self.series_code) + '",' + '"issue_no":' + '"' + str(self.issue_no) + '",' + '"issue_seq_no":' + '"' + str(self.issue_seq_no) + '",' + '"volume_tag":' + '"' + str(self.volume_tag) + '",' + '"max_issue":' + '"' + str(self.max_issue) + '",' + '"price":' + '"' + str(self.price) + '",' + '"publisher":' + '"' + str(self.publisher) + '",' + '"upc_no":' + '"' + str(self.upc_no) + '",' + '"short_isbn_no":' + '"' + str(self.short_isbn_no) + '",' + '"ean_no":' + '"' + str(self.ean_no) + '",' + '"cards_per_pack":' + '"' + str(self.cards_per_pack) + '",' + '"pack_per_box":' + '"' + str(self.pack_per_box) + '",' + '"box_per_case":' + '"' + str(self.box_per_case) + '",' + '"discount_code":' + '"' + str(self.discount_code) + '",' + '"increment":' + '"' + str(self.increment) + '",' + '"prnt_date":' + '"' + str(self.prnt_date) + '",' + '"foc_vendor":' + '"' + str(self.foc_vendor) + '",' + '"ship_date":' + '"' + str(self.ship_date) + '",' + '"srp":' + '"' + str(self.srp) + '",' + '"category":' + '"' + str(self.category) + '",' + '"genre":' + '"' + str(self.genre) + '",' + '"brand_code":' + '"' + str(self.brand_code) + '",' + '"mature":' + '"' + str(self.mature) + '",' + '"adult":' + '"' + str(self.adult) + '",' + '"oa":' + '"' + str(self.oa) + '",' + '"caut1":' + '"' + str(self.caut1) + '",' + '"caut2":' + '"' + str(self.caut2) + '",' + '"caut3":' + '"' + str(self.caut3) + '",' + '"resol":' + '"' + str(self.resol) + '",' + '"note_price":' + '"' + str(self.note_price) + '",' + '"order_form_notes":' + '"' + str(self.order_form_notes) + '",' + '"page":' + '"' + str(self.page) + '",' + '"writer":' + '"' + str(self.writer) + '",' + '"artist":' + '"' + str(self.artist) + '",' + '"cover_artist":' + '"' + str(self.cover_artist) + '",' + '"colorist":' + '"' + str(self.colorist) + '",' + '"alliance_sku":' + '"' + str(self.alliance_sku) + '",' + '"foc_date":' + '"' + str(self.foc_date) + '",' + '"offered_date":' + '"' + str(self.offered_date) + '",' + '"number_of_pages":' + '"' + str(self.number_of_pages) + '",' + '"unit_weight":' + '"' + str(self.unit_weight) + '",' + '"unit_length":' + '"' + str(self.unit_length) + '",' + '"unit_width":' + '"' + str(self.unit_width) + '",' + '"unit_height":' + '"' + str(self.unit_height) + '",' + '"case_weight":' + '"' + str(self.case_weight) + '",' + '"case_length":' + '"' + str(self.case_length) + '",' + '"case_width":' + '"' + str(self.case_width) + '",' + '"case_height":' + '"' + str(self.case_height) + '"}'