tasklink/
├── backend/ # Spring Boot 백엔드 프로젝트
│ ├── src/ # 소스 코드
│ │ ├── main/
│ │ │ ├── java/
│ │ │ │ └── com/example/todo/
│ │ │ │ ├── TodoApplication.java
│ │ │ │ └── controller/ # 컨트롤러 코드
│ │ │ │ └── TodoController.java
│ │ │ ├── resources/
│ │ │ ├── application.properties # Spring Boot 설정
│ │ │ └── static/ # 정적 파일
│ ├── build.gradle # Gradle 빌드 설정 파일
│ ├── settings.gradle # Gradle 설정
│ └── Dockerfile # 백엔드용 Dockerfile
│
├── frontend/ # Nextjs 프론트엔드 프로젝트
│ ├── public/ # 정적 파일 (HTML, 이미지 등)
│ │ └── index.html
│ ├── src/ # 소스 코드
│ │ ├── components/ # React 컴포넌트
│ │ │ └── TodoList.tsx
│ │ ├── App.tsx
│ │ └── index.tsx
│ ├── package.json # Node.js 프로젝트 설정
│ ├── tsconfig.json # TypeScript 설정 파일
│ └── Dockerfile # 프론트엔드용 Dockerfile
│
├── docker-compose.yml # Docker Compose 설정
└── .github/ # GitHub Actions 워크플로우 파일
└── workflows/
└── ci-cd.yml # CI/CD 파이프라인 설정
