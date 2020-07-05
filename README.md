```
git clone git@github.com:cyadxx/bank-system.git
```

### frontend

```bash
$ cd frontend/
$ npm install
$ npm run dev
```

### backend

先安装该库：
```bash
$ sudo apt install libmysqlclient-dev
```

然后安装 `pipenv`：
```bash
$ pip install pipenv
```

然后进入后端目录，进行后端的依赖安装：
```bash
$ cd backend/
$ pipenv install
$ pipenv shell
```