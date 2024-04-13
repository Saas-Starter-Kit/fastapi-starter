# 
FROM python:3.12 as requirements-stage

# 
WORKDIR /tmp

# 
RUN pip install poetry

# 
COPY ./pyproject.toml ./poetry.lock* /tmp/

# 
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

# 
FROM python:3.12

# 
WORKDIR /code

# 
COPY --from=requirements-stage /tmp/requirements.txt /code/requirements.txt

# 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt


RUN pip install uvicorn
RUN pip install fastapi

# 
COPY ./app /code/app

#CMD ["sh", "-c", "echo $PATH && ls -l /usr/local/bin"]

# 
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]