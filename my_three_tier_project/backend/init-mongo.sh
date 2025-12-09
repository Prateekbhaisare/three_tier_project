# !/bin/bash
echo "Seeding MongoDB with sample_posts.json..."

mongoimport \
  --db wanderlust \
  --collection posts \
  --file /data/sample_posts.json \
  --jsonArray