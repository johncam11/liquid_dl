FROM python:3.6-alpine3.6

EXPOSE 8000
VOLUME ["/downloads"]

COPY . /app
WORKDIR /app

# Temp (alpine mirror having issues)
RUN echo http://dl-2.alpinelinux.org/alpine/v3.6/main > /etc/apk/repositories; \
    echo http://dl-2.alpinelinux.org/alpine/v3.6/community >> /etc/apk/repositories

RUN apk --update --no-cache add ffmpeg wget
RUN pip install youtube-dl
RUN pip install -r requirements.txt

RUN apt-get update \
    && apt-get install -y git
    
RUN git clone https://github.com/flyingrub/scdl.git 
RUN python3 /scdl/setup.py install

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
