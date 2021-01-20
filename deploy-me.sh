cd /home/ec2-user/coach-app/  \
&& git pull origin main \
&& docker system prune -a -f \
&& docker-compose -f docker-compose.prod.yml down \
&& docker-compose -f docker-compose.prod.yml up -d --build