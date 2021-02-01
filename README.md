# # README

Esta aplicação é uma API com a finalidade de realização de um teste na empresa Quero Educação.

**Aplicação no Heroku:** <https://quero-bolsa-api.herokuapp.com/>  
**API username:** admin  
**API password:** 123456

### Tecnologias Utilizadas 
* Ruby 3.0
* Rails 6.1.1
* Docker 19.03.12
* Docker Compose 1.24.1 
* Rspec 4.0.2 (TDD)
* Rubocop 1.9 (Analise de codigo)
* Postgresql 13.1

### Utilizando Docker Container
* Construção do container:
```
$ docker-compose build
```
* Acessando o container via terminal:
```
$ docker-compose run --rm web bash
```
* Subindo container com servidor inicializado:
```
$ docker-compose up web
```
### Criando e populando Banco de Dados
1. Acesse o container via terminal:
```
$ docker-compose run --rm web bash
```
2. Criando banco no ambiente de desenvolvimento:
```
$ rails db:setup
```
3. Criando banco no ambiente de teste:
```
$ rails db:create db:migrate RAILS_ENV=test
```
### Rodando os Testes Automatizados

1. Acesse o container via terminal:
```
$ docker-compose run --rm web bash
```
2. Rodando testes:
```
$ rspec
```
### Rodando o Rubocop

1. Acesse o container via terminal:
```
$ docker-compose run --rm web bash
```
2. Rodando rubocop:
```
$ rubocop
```
### Utilizando a API
##### <span style="color:green;margin:010px">[POST]</span><span style=color:blue> Login</span>
* Autenticando na API:
>Request:
```
URL: http://localhost:3000/login
Method: POST
Body: { "username": "admin", "password": "123456" }
Headers: Content-Type: application/json
```
>Response:
~~~json
{
  "user": {
    "id": "ea9f2245-bca3-46e0-a9fd-59403b826feb",
    "username": "admin"
  },
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZWE5ZjIyNDUtYmNhMy00NmUwLWE5ZmQtNTk0MDNiODI2ZmViIn0.WjWRQ9KvaUyjRycr506Erz8QwuJmoEPWeB8otkTUe6E"
}
~~~
* Utilizando o token JWT:
>Adicionar em todas as requisições o header:
```
Authorization: Bearer #{SEU_TOKEN}
```
##### <span style="color:green;margin:010px">[GET]</span><span style=color:blue> Listando cursos</span>
* Listando todos os cursos:
>Request:
```
http://localhost:3000/courses
```
>Response:
~~~json
[
  {
    "name": "Bachelor of Arts in Forensic Psychology in Systems Arts",
    "kind": "presential",
    "level": "master",
    "shift": "night",
    "campus": [
      {
        "name": "Alaska",
        "city": "Harrisberg",
        "university": {
          "name": "College of Hawaii",
          "score": "2.08",
          "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
        }
      },
      {
        "name": "North Dakota",
        "city": "Stokesbury",
        "university": {
          "name": "Rhode Island Academy of Architecture",
          "score": "1.95",
          "logo_url": "https://via.placeholder.com/300x300/60928d/79accf.png?text="
        }
      },
      {
        "name": "Windside",
        "city": "Lake Janey",
        "university": {
          "name": "Greenside School",
          "score": "4.39",
          "logo_url": "https://via.placeholder.com/300x300/6cbeb7/8b5387.png?text="
        }
      }
    ]
  }
]
~~~
* Listando cursos filtrando pela universidade:
>Request:
```
http://localhost:3000/courses?university[name]=College of Hawaii
```
>Response:
~~~json
[
  {
    "name": "Bachelor of Arts in Forensic Psychology in Systems Arts",
    "kind": "presential",
    "level": "master",
    "shift": "night",
    "campus": [
      {
        "name": "Alaska",
        "city": "Harrisberg",
        "university": {
          "name": "College of Hawaii",
          "score": "2.08",
          "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
        }
      }
    ]
  },
  {
    "name": "Master of Physics in Medical Science",
    "kind": "presential",
    "level": "bachelor",
    "shift": "afternoon",
    "campus": [
      {
        "name": "Alaska",
        "city": "Harrisberg",
        "university": {
          "name": "College of Hawaii",
          "score": "2.08",
          "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
        }
      }
    ]
  }
]
~~~
* Listando cursos filtrando por kind,level e/ou shift:
>Request:
```
http://localhost:3000/courses?kind=presential&level=bachelor&shift=night
```
>Response:
~~~json
[
  {
    "name": "Master of Business Engineering in Marketing Production",
    "kind": "presential",
    "level": "bachelor",
    "shift": "night",
    "campus": [
      {
        "name": "Wyoming",
        "city": "North Pinkie",
        "university": {
          "name": "Windridge School",
          "score": "4.57",
          "logo_url": "https://via.placeholder.com/300x300/31e728/e85714.png?text="
        }
      },
      {
        "name": "Larkcrest",
        "city": "West Lenora",
        "university": {
          "name": "Lakedale School",
          "score": "1.07",
          "logo_url": "https://via.placeholder.com/300x300/fbaed8/68ce80.png?text="
        }
      },
      {
        "name": "Northspur",
        "city": "Halvorsonchester",
        "university": {
          "name": "Windridge School",
          "score": "4.57",
          "logo_url": "https://via.placeholder.com/300x300/31e728/e85714.png?text="
        }
      }
    ]
  }
]
~~~

##### <span style="color:green;margin:010px">[GET]</span><span style=color:blue> Listando Ofertas</span>
* Listando todas as ofertas:
>Request:
```
http://localhost:3000/offers
```
>Response:
~~~json
[
  {
    "full_price": "1878.57",
    "price_with_discount": "1485.82",
    "discount_percentage": 27,
    "start_date": "2021-02-03",
    "enrollment_semester": "2021.1",
    "enabled": true,
    "course": {
      "name": "Bachelor of Arts in Forensic Psychology in Systems Arts",
      "kind": "presential",
      "level": "master",
      "shift": "night"
    },
    "campus": {
      "name": "Alaska",
      "city": "Harrisberg"
    },
    "university": {
      "name": "College of Hawaii",
      "score": "2.08",
      "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
    }
  },
  {
    "full_price": "1721.38",
    "price_with_discount": "1059.0",
    "discount_percentage": 14,
    "start_date": "2021-02-09",
    "enrollment_semester": "2021.1",
    "enabled": true,
    "course": {
      "name": "Bachelor of Arts in Forensic Psychology in Systems Arts",
      "kind": "presential",
      "level": "master",
      "shift": "night"
    },
    "campus": {
      "name": "Windside",
      "city": "Lake Janey"
    },
    "university": {
      "name": "Greenside School",
      "score": "4.39",
      "logo_url": "https://via.placeholder.com/300x300/6cbeb7/8b5387.png?text="
    }
  }
]
~~~
* Listando ofertas filtrando por curso:
>Request:
```
http://localhost:3000/offers?course[name]=Master of Computational Finance in Business Production
```
>Response:
~~~json
[
  {
    "full_price": "1604.32",
    "price_with_discount": "1008.56",
    "discount_percentage": 19,
    "start_date": "2021-02-04",
    "enrollment_semester": "2021.2",
    "enabled": true,
    "course": {
      "name": "Master of Computational Finance in Business Production",
      "kind": "distance learning",
      "level": "master",
      "shift": "morning"
    },
    "campus": {
      "name": "Lakefield",
      "city": "Manueltown"
    },
    "university": {
      "name": "Northpoint Academy of Education",
      "score": "1.25",
      "logo_url": "https://via.placeholder.com/300x300/c5f459/b08723.png?text="
    }
  },
  {
    "full_price": "1890.59",
    "price_with_discount": "1077.42",
    "discount_percentage": 7,
    "start_date": "2021-02-12",
    "enrollment_semester": "2021.1",
    "enabled": true,
    "course": {
      "name": "Master of Computational Finance in Business Production",
      "kind": "distance learning",
      "level": "master",
      "shift": "morning"
    },
    "campus": {
      "name": "Kansas",
      "city": "D'Amoreton"
    },
    "university": {
      "name": "College of Hawaii",
      "score": "2.08",
      "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
    }
  }
 ]
 ~~~
 * Listando ofertas filtrando por kind e city:
>Request:
```
http://localhost:3000/offers?course[kind]=presential&campus[city]=Coreystad
```
>Response:
~~~json
[
  {
    "full_price": "1954.63",
    "price_with_discount": "1290.26",
    "discount_percentage": 20,
    "start_date": "2021-02-14",
    "enrollment_semester": "2021.1",
    "enabled": true,
    "course": {
      "name": "Bachelor of Economics in Social Administration",
      "kind": "presential",
      "level": "technologist",
      "shift": "night"
    },
    "campus": {
      "name": "Hawaii",
      "city": "Coreystad"
    },
    "university": {
      "name": "College of Hawaii",
      "score": "2.08",
      "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
    }
  },
  {
    "full_price": "1842.11",
    "price_with_discount": "1067.7",
    "discount_percentage": 6,
    "start_date": "2021-02-26",
    "enrollment_semester": "2021.2",
    "enabled": true,
    "course": {
      "name": "Master of Engineering Management in Medical Production",
      "kind": "presential",
      "level": "graduation",
      "shift": "night"
    },
    "campus": {
      "name": "Hawaii",
      "city": "Coreystad"
    },
    "university": {
      "name": "College of Hawaii",
      "score": "2.08",
      "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
    }
  }
]
~~~
* Listando ofertas ordenando por menor price_with_discount:
>Request:
```
http://localhost:3000/offers?price_with_discount=asc
```
>Response:
~~~json
[
  {
    "full_price": "1604.32",
    "price_with_discount": "1008.56",
    "discount_percentage": 19,
    "start_date": "2021-02-04",
    "enrollment_semester": "2021.2",
    "enabled": true,
    "course": {
      "name": "Master of Computational Finance in Business Production",
      "kind": "distance learning",
      "level": "master",
      "shift": "morning"
    },
    "campus": {
      "name": "Lakefield",
      "city": "Manueltown"
    },
    "university": {
      "name": "Northpoint Academy of Education",
      "score": "1.25",
      "logo_url": "https://via.placeholder.com/300x300/c5f459/b08723.png?text="
    }
  },
  {
    "full_price": "1587.25",
    "price_with_discount": "1022.4",
    "discount_percentage": 38,
    "start_date": "2021-02-19",
    "enrollment_semester": "2021.2",
    "enabled": true,
    "course": {
      "name": "Bachelor of Economics in Social Administration",
      "kind": "presential",
      "level": "technologist",
      "shift": "night"
    },
    "campus": {
      "name": "New York",
      "city": "Gleasonchester"
    },
    "university": {
      "name": "Windridge School",
      "score": "4.57",
      "logo_url": "https://via.placeholder.com/300x300/31e728/e85714.png?text="
    }
  }
]
~~~
* Listando ofertas ordenando por maior price_with_discount:
>Request:
```
http://localhost:3000/offers?price_with_discount=desc
```
>Response:
~~~json
[
  {
    "full_price": "1592.01",
    "price_with_discount": "1497.78",
    "discount_percentage": 17,
    "start_date": "2021-02-17",
    "enrollment_semester": "2021.2",
    "enabled": true,
    "course": {
      "name": "Master of Computational Finance in Business Production",
      "kind": "distance learning",
      "level": "master",
      "shift": "morning"
    },
    "campus": {
      "name": "Hawaii",
      "city": "Coreystad"
    },
    "university": {
      "name": "College of Hawaii",
      "score": "2.08",
      "logo_url": "https://via.placeholder.com/300x300/1154ab/ed9136.png?text="
    }
  },
  {
    "full_price": "1878.91",
    "price_with_discount": "1495.97",
    "discount_percentage": 16,
    "start_date": "2021-01-29",
    "enrollment_semester": "2021.2",
    "enabled": true,
    "course": {
      "name": "Master of Science in Management in Marketing Administration",
      "kind": "presential",
      "level": "graduation",
      "shift": "afternoon"
    },
    "campus": {
      "name": "Iowa",
      "city": "Lake Linnie"
    },
    "university": {
      "name": "Greenside School",
      "score": "4.39",
      "logo_url": "https://via.placeholder.com/300x300/6cbeb7/8b5387.png?text="
    }
  }
 ]
~~~