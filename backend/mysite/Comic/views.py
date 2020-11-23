import csv,io,os
from django.http import HttpResponse
from .models import Comic
from . import views

def index(request):
    with open('masterData.csv') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            p=Comic(diamd_no=row[''],
                stock_no=row[''],
                parent_item_no_alt=row[''],
                bounce_use_item=row[''],
                full_title=row[''],
                main_desc=row[''],
                variant_desc=row[''],
                series_code=row[''],
                issue_no=row[''],
                issue_seq_no=row[''],
                volume_tag=row[''],
                max_issue=row[''],
                price=row[''],
                publisher=row[''],
                upc_no=row[''],
                short_isbn_no=row[''],
                ean_no=row[''],
                cards_per_pack=row[''],
                pack_per_box=row[''],
                box_per_case=row[''],
                discount_code=row[''],
                increment=row[''],
                prnt_date=row[''],
                foc_vendor=row[''],
                ship_date=row[''],
                srp=row[''],
                category=row[''],
                genre=row[''],
                brand_code=row[''],
                mature=row[''],
                adult=row[''],
                oa=row[''],
                caut1=row[''],
                caut2=row[''],
                caut3=row[''],
                resol=row[''],
                note_price=row[''],
                order_form_notes=row[''],
                page=row[''],
                writer=row[''],
                artist=row[''],
                cover_artist=row[''],
                colorist=row[''],
                alliance_sku=row[''],
                foc_date=row[''],
                offered_date=row[''],
                number_of_pages=row[''],
                unit_weight=row[''],
                unit_length=row[''],
                unit_width=row[''],
                unit_height=row[''],
                case_weight =row['case_weight'],
                case_length=row['case_length'],
                case_width=row['case_width'],
                case_height=row['case_height'],    
               )
            p.save()

    return HttpResponse("Hello, world")

def search(request, query):
    comics = Comic.objects.filter(full_title__contains=query)
    json = "comics: ["
    for comic in comics:
        json += str(comic)
        json += ","
    json[:-1]
    return HttpResponse(json)