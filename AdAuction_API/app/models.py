from app.database import db

class AdAuction(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    date = db.Column(db.DateTime, nullable = False)
    site_id = db.Column(db.Integer, nullable = False)
    ad_type_id = db.Column(db.Integer, nullable = False)
    geo_id = db.Column(db.Integer, nullable = False)
    device_category_id = db.Column(db.Integer, nullable = False)
    advertiser_id = db.Column(db.Integer, nullable = False)
    order_id = db.Column(db.Integer, nullable = True)
    line_item_type_id = db.Column(db.Integer, nullable = True)
    os_id = db.Column(db.Integer, nullable = True)
    integration_type_id = db.Column(db.Integer, nullable = True)
    monetization_channel_id = db.Column(db.Integer, nullable = True)
    ad_unit_id = db.Column(db.Integer, nullable = True)
    total_impressions = db.Column(db.Integer, nullable = False)
    total_revenue = db.Column(db.Float, nullable = False)
    viewable_impressions = db.Column(db.Integer, nullable = False)
    measurable_impressions = db.Column(db.Integer, nullable = False)
    revenue_share_percent = db.Column(db.Float, nullable = False)

    def __repr__(self):
        return f"<AdAuction {self.id} - Site {self.site_id} - {self.date}>"