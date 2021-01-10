FROM python:3.9.1

RUN apt-get update

COPY requirements.txt .

RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip freeze > requirements.txt

# install zh language, results in 13Gb size image
# this creates a file `/cc.zh.300.bin`
RUN python -c "import fasttext.util; fasttext.util.download_model('zh')" && rm /cc.zh.300.bin.gz

COPY . /app
ENV PYTHONPATH "${PYTHONPATH}:/app"