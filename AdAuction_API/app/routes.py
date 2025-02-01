from flask import Blueprint, jsonify

api = Blueprint('api', __name__)

@api.route('/')
def home():
    return jsonify({"message": "API is running!"})

@api.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({"error":"No file provided"}), 400
    
    file = request.files['file']

    if file.filename == '':
        return jsonify({"error":"Invalid file name"}), 400
    
    try:

        df = pd.read_csv(file)

        expected_columns = [
            "date", "site_id", "ad_type_id", "geo_id", "device_category_id",
            "advertiser_id", "order_id", "line_item_type_id", "os_id", "integration_type_id", 
            "monetization_channel_id", "ad_unit_id", "total_impressions", "total_revenue", 
            "viewable_impressions", "mesurable_impressions", "revenue_share_percent"
        ]

        if not all(col in df.columns for col in expected_columns):
            return jsonify({"error": "Missing columns in the CSV file"}),400
        
        df['date'] = pd.to_datetime(df['date'], errors = 'coerce')

        df = df.where(pd.notnull(df), None)

        auctions = [
            AdAuction(
                date = row['date'],
                site_id = row['site_id'],
                ad_type_id = row['ad_type_id'],
                geo_id = row['geo_id'],
                device_category_id = row['device_category_id'],
                advertiser_id = row['advertiser_id'],
                order_id = row['order_id'],
                line_item_type_id = row['line_item_type_id'],
                os_id = row['os_id'],
                integration_type_id = row['integration_type_id'],
                monetization_channel_id = row['monetization_channel_id'],
                ad_unit_id = row['ad_unit_id'],
                total_impressions = row['total_impressions'],
                total_revenue = row['total_revenue'],
                viewable_impressions = row['viewable_impressions'],
                measurable_impressions = row['measurable_impressions'],
                revenue_share_percent = row['revenue_share_percent']
            )
            for _, row in df.iterrows()
        ]

        db.session.bulk_save_objects(auctions)
        db.session.commit()

        return jsonify({"message": f"{len(df)} rows successfully inserted"}), 201
    
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": f"Error during import: {str(e)}"}), 500