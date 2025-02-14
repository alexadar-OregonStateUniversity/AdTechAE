from datetime import datetime 
import json
import csv 
import sys


def Receipts_ETL(input_file: str, output_file_a: str, output_file_b: str) -> None:
    """
    Extracts Receipts data from the receipts.jsonl file(s) and appends the data to the two receipts tables.
    The two receipts tables are Receipts_Order and Receipts_Items. 
    Processing is done in the same function, rather than two, to save resources.
    This function will always assume that the input file is valid JSON.

    Function Process:
        - Opens input JSONL file for reading. Example: `../2b-Correction-Data/receipts.jsonl`
        - Extracts target data from each line from the input file
        - Transforms the target data for processing
        
    This function does not return anything.  
    """

    # Open JSONL Input File
    infile = open(input_file, "r", encoding="utf-8")
    
    # Open JSONL Input File
    with open(input_file, "r", encoding="utf-8") as infile, \
         open(output_file_a, 'w', newline='', encoding="utf-8") as outfile_a, \
         open(output_file_b, 'w', newline='', encoding="utf-8") as outfile_b:

        writer_a = csv.writer(outfile_a, delimiter=';')
        writer_b = csv.writer(outfile_b, delimiter=';')
        
        # Process JSONL File Line by Line
        for line in infile:
            
            # Extract Desired Data                        
            line_json = json.loads(line)
            
            ### ---------------------------------------------------------------------------------------------------
            ### Receipts Order 
            ### ---------------------------------------------------------------------------------------------------

            # Receipt Order Field Extraction
            receipt_id = line_json.get("_id", {}).get("$oid", "")  
            user_id = line_json.get("userId", "")
            bonus_points_earned = line_json.get("bonusPointsEarned","")
            bonus_earned_reason = line_json.get("bonusPointsEarnedReason","")
            create_date = line_json.get("createDate",{}).get("$date", "")
            date_scanned = line_json.get("dateScanned",{}).get("$date", "")
            finished_date = line_json.get("finishedDate",{}).get("$date", "")
            modify_date = line_json.get("modifyDate",{}).get("$date","")
            points_award_date = line_json.get("pointsAwardedDate",{}).get("$date","")
            points_earned = line_json.get("pointsEarned","")
            purchase_date = line_json.get("purchaseDate",{}).get("$date","")
            purchased_item_count = line_json.get("purchasedItemCount","")
            rewards_status = line_json.get("rewardsReceiptStatus","")
            total_spent = line_json.get("totalSpent","")
            
            # Transform Target Data
            def convert_timestamp(timestamp):
                try:
                    return str(datetime.utcfromtimestamp(timestamp / 1000))
                except:
                    return ""

            # Receipt Order Date Field Transformations
            create_date_str = convert_timestamp(create_date)
            date_scanned_str = convert_timestamp(date_scanned)
            finished_date_str = convert_timestamp(finished_date)
            modify_date_str = convert_timestamp(modify_date)
            points_award_date_str = convert_timestamp(points_award_date)
            purchase_date_str = convert_timestamp(purchase_date)

            
            # Load Transformed Data
            data_a = [
                receipt_id,
                user_id,
                bonus_points_earned,
                bonus_earned_reason,
                create_date_str,
                date_scanned_str,
                finished_date_str,
                modify_date_str,
                points_award_date_str,
                points_earned,
                purchase_date_str,
                purchased_item_count,
                rewards_status,
                total_spent
            ]
            
            # print(data_a)
            
            writer_a.writerow(data_a) 

            ### ---------------------------------------------------------------------------------------------------
            ### Receipts Items 
            ### ---------------------------------------------------------------------------------------------------
            
            # Receipt Items Field Extraction
            receipt_id = line_json.get("_id", {}).get("$oid", "")  
            user_id = line_json.get("userId", "")
            rewards_items = line_json.get("rewardsReceiptItemList", [])
            for item in rewards_items:
                item_barcode = item.get("barcode", "")
                brand_code = item.get("brandCode", "")
                competitive_product = item.get("competitiveProduct", "")
                competitor_rewards_group = item.get("competitorRewardsGroup", "")
                deleted = item.get("deleted", "")
                item_description = item.get("description", "")
                discounted_item_price = item.get("discountedItemPrice", "")
                final_price = item.get("finalPrice", "")
                item_number = item.get("itemNumber", "")
                item_price = item.get("itemPrice", "")
                metabrite_campaign_id = item.get("metabriteCampaignId", "")
                needs_fetch_review = item.get("needsFetchReview", "")
                needs_fetch_review_reason = item.get("needsFetchReviewReason", "")
                original_final_price = item.get("originalFinalPrice", "")
                original_metabrite_barcode = item.get("originalMetaBriteBarcode", "")
                original_metabrite_description = item.get("originalMetaBriteDescription", "")
                original_metabrite_item_price = item.get("originalMetaBriteItemPrice", "")
                original_metabrite_quantity_purchased = item.get("originalMetaBriteQuantityPurchased", "")
                original_receipt_item_text = item.get("originalReceiptItemText", "")
                partner_item_id = item.get("partnerItemId", "")
                points_earned = item.get("pointsEarned", "")
                points_not_awarded_reason = item.get("pointsNotAwardedReason", "")
                points_payer_id = item.get("pointsPayerId", "")
                prevent_target_gap_points = item.get("preventTargetGapPoints", "")
                price_after_coupon = item.get("priceAfterCoupon", "")
                quantity_purchased = item.get("quantityPurchased", "")
                rewards_group = item.get("rewardsGroup", "")
                rewards_product_partner_id = item.get("rewardsProductPartnerId", "")
                target_price = item.get("targetPrice", "")
                user_flagged_barcode = item.get("userFlaggedBarcode", "")
                user_flagged_description = item.get("userFlaggedDescription", "")
                user_flagged_new_item = item.get("userFlaggedNewItem", "")
                user_flagged_price = item.get("userFlaggedPrice", "")
                user_flagged_quantity = item.get("userFlaggedQuantity", "")

                # print(user_flagged_quantity)
                
                data_b = [
                    receipt_id,
                    user_id,
                    item_barcode,
                    brand_code,
                    competitive_product,
                    competitor_rewards_group,
                    deleted,
                    item_description,
                    discounted_item_price,
                    final_price,
                    item_number,
                    item_price,
                    metabrite_campaign_id,
                    needs_fetch_review,
                    needs_fetch_review_reason,
                    original_final_price,
                    original_metabrite_barcode,
                    original_metabrite_description,
                    original_metabrite_item_price,
                    original_metabrite_quantity_purchased,
                    original_receipt_item_text,
                    partner_item_id,
                    points_earned,
                    points_not_awarded_reason,
                    points_payer_id,
                    prevent_target_gap_points,
                    price_after_coupon,
                    quantity_purchased,
                    rewards_group,
                    rewards_product_partner_id,
                    target_price,
                    user_flagged_barcode,
                    user_flagged_description,
                    user_flagged_new_item,
                    user_flagged_price,
                    user_flagged_quantity
                ] 
                
                # print(data_b)
                
                writer_b.writerow(data_b)

    infile.close() 
    outfile_a.close()  
    outfile_b.close()  

    print("Receipts ETL Complete")
    return


if __name__ == "__main__":

    input_file = sys.argv[1]
    output_file_a = sys.argv[2]
    output_file_b = sys.argv[3]

    Receipts_ETL(input_file, output_file_a, output_file_b)