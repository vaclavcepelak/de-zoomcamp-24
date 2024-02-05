-- Docs: https://docs.mage.ai/guides/sql-blocks
SELECT vendor_id, COUNT(vendor_id) as cnt FROM mage.green_taxi GROUP BY vendor_id ORDER BY vendor_id;