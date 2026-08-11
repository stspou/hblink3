FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /opt/hblink3

RUN useradd \
    --uid 54000 \
    --create-home \
    --shell /usr/sbin/nologin \
    radio

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY *.py ./
COPY entrypoint /entrypoint

RUN chmod +x /entrypoint && \
    chown -R radio:radio /hblink3 /entrypoint

USER radio

ENTRYPOINT ["/entrypoint"]
