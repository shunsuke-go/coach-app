cd /home/ec2-user/coach-app/  \
&& git pull origin main \
&& docker-compose -f docker-compose.prod.yml down \
&& docker-compose -f docker-compose.prod.yml up -d --build \
&& docker system prune -f