cd /home/ec2-user/coach-app/ \
&& docker-compose -f docker-compose.prod.yml down \
&& docker system prune -af \
&& git pull origin main \
&& docker-compose -f docker-compose.prod.yml up -d --build \
&& docker-compose -f docker-compose.prod.yml down \
&& docker-compose -f docker-compose.prod.yml up -d