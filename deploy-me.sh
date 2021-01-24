cd /home/ec2-user/coach-app/ \
&& docker-compose -f docker-compose.prod.yml down \
&& docker system prune -af \
&& git pull origin main \
&& docker-compose -f docker-compose.prod.yml up -d --build \
&& docker-compose -f docker-compose.prod.yml run web rails assets:clobber RAILS_ENV=production \
&& docker-compose -f docker-compose.prod.yml run web rails assets:precompile RAILS_ENV=production