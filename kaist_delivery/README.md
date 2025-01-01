# Introduction

## K-밥심 🍚

> Korean은 밥심! Kaistian도 밥심!!
기숙사에서 편하게 밥을 먹기를 바라는 마음으로 만든 어플, **K-밥심** 입니다☺️
> 

1️⃣ **기숙사까지 배달 오늘 식당** 정보를 간편하게 확인할 수 있어요. 

2️⃣ 식당을 고르기 어려울 땐, ‘**맛집 소개 Tab**’을 이용해 보세요!

3️⃣ 메뉴를 고르기 어려운 분들을 위해 **랜덤으로 메뉴**를 뽑아드립니다!

# Team

### 김대영 
<img src="https://github.com/user-attachments/assets/fcf6cbc6-553f-432f-bbe5-ac1a83da3706" alt="김대영" width="200">

- 부산대학교 정보컴퓨터공학부 20학번

### 최연우  
<img src="https://github.com/user-attachments/assets/6f8acc69-c283-4932-9a15-c38b78502143" alt="최연우" width="200">

- 카이스트 전산학부 22학번


# Tech Stack

- **개발 언어** : ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

- **프레임워크** : ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)

- **IDE** : ![Android Studio](https://img.shields.io/badge/Android_Studio-3DDC84?style=for-the-badge&logo=android-studio&logoColor=white)

- **디자인** : ![Figma](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)

- **협업 툴** : ![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

# App Details


## 1. Splash Screen

> 앱을 처음 실행할 때 나타나는 화면
> 

[Splash Screen](https://github.com/user-attachments/assets/2f14fc1d-4868-469f-98fc-cf13396920ad)

- `flutter_native_splash`를 이용하여 구현

## 2. Tab 1 (Home)

> KAIST 기숙사까지 배달 오는 가게에 대한 정보를 제공하는 탭
>
 
   [Tab 1. 전체 기능 실행 영상](https://github.com/user-attachments/assets/6a075380-92ed-481c-9d0b-4c09697199a6)

   [Tab 1. 카테고리 스와이프 기능](https://github.com/user-attachments/assets/cb133cd8-5f3c-4157-aeb2-340296cbf605)
 
   [Tab 1. 전화 연결 기능](https://github.com/user-attachments/assets/37360387-c927-4a39-a470-7886ba0a5c34)

   [Tab 1. 지도 연결 기능](https://github.com/user-attachments/assets/4afa0062-6831-40d9-8e9a-39b15f5d2336)


### 2-1. 가게 정보 리스트

- 각 가게의 이름, 전화 번호, 영업 시간, 카테고리, 음식 사진에 대한 정보를 `data.json` 파일에 저장함.
- 각 가게의 정보를 `RestaurantCard` 위젯을 사용해 **Card 형태**로 표시하고, 이를 `ListView`로 나타냄.
- **영업 시간이 아닌 가게**는 Card가 회색 처리되며 목록의 가장 아래쪽에 위치하도록 함.
- `url_launcher` 패키지를 이용하여 **전화 연결 기능**과 **네이버 지도 연결 기능**을 구현.

### 2-2. 카테고리 별 가게 리스트

- 탭 상단에 **수평 스크롤이 가능한 카테고리 버튼**이 있음.
- 각 카테고리를 선택하면 해당 카테고리에 속한 가게 정보를 **필터링**하여 보여줌.
- `PageView`를 활용하여 사용자가 **스와이프 동작**으로 카테고리를 변경할 수 있음.

## 3. Tab 2

> 매일매일 다른 맛집을 소개해주는 탭
> 

[Tab 2. 전체 기능 영상](https://github.com/user-attachments/assets/b7096049-bc7e-4e7e-9f27-346ef314327d)

### 3-1. 맛집 추천 카드

- 각 맛집 정보는 `content_data.json` 파일에서 불러와서 Card 형태로 보여주며, 매일 `Seed` 값을 새롭게 생성하여 맛집 리스트를 **랜덤**으로 섞어서 표시함.
- `PageView`를 이용해서 카드를 좌우로 **스와이프** 가능하도록 하였으며, 오늘의 맛집은 테두리를 메인 테마 색으로 칠하여 보려줌.
- 카드 디자인은 `viewportFraction`을 활용하여 중심 카드를 강조하여 보여줌.
- ‘맛집 소개’ **아이콘을 더블 클릭**하면 스와이프했던 순서가 초기화되어 다시 오늘의 맛집이 가운데에 보임.

## 4. Tab 3

> 나의 Pick 목록에서 랜덤으로 오늘의 Pick을 추천해주는 탭
> 

[Tab 3. 오늘의 Pick](https://github.com/user-attachments/assets/b606b773-568b-4d24-9295-9aa1063c0c32)

[Tab 3. 나의 Pick 관리](https://github.com/user-attachments/assets/e5b9a855-1c4f-43c7-a9e2-587418a4bf7c)

### 4-1. 오늘의 Pick

- 사용자가 저장한 **“나의 Pick”** 목록에서 **랜덤 추천 기능**을 이용해서 오늘의 메뉴를 제안함.
- **‘Pick 뽑기’** 버튼을 누르면 `PopUp` 창이 뜨며, `animated_text_kit` 패키지를 이용해서 애니메이션 효과를 추가함.
    - `TyperAnimatedText` 를 이용해서 **타이핑 애니메이션** 구현.
    - `ScaleTransition` 를 이요해서 **확대-축소 애니메이션** 구현.
    - 애니메이션이 끝난 후 일정 시간 동안 팝업이 유지된 뒤 자동으로 닫힘.
- **‘다시 뽑기’** 버튼을 눌러서 다시 새롭게 오늘의 Pick을 뽑을 수 있음.

### 4-2. 나의 Pick 관리

- **‘수정하기’** 버튼을 이용해서 나의 Pick을 관리할 수 있음.
- 화면 상단의 입력창을 통해 메뉴를 입력하고 **‘Pick 추가’** 버튼을 누르면 나의 Pick 목록에 저장됨.
    - 추가된 Pick은 **로컬 데이터베이스**에 저장되고 UI 리스트에 반영됨.
- `AlertDialog`를 이용하여 목록에서 각 메뉴를 선택하면 수정 및 삭제가 가능한 다이얼로그가 뜨도록 함.

### 4-3. 나의 Pick 데이터베이스

- 사용자의 Pick을 저장하는 DB 제작.
- UI/Controller가 DB와 직접 상호작용하지 않도록, dao/repository를 나누어 구현

## 5. 검색 기능

> AppBar 오른쪽에 위치한 검색 아이콘을 통해 모든 페이지에서 검색 기능 이용 가능
> 

[Tab 1. 검색 기능](https://github.com/user-attachments/assets/30bf1116-6dd2-4758-9c7b-5fcff300650b)

[Tab 2. 검색 기능](https://github.com/user-attachments/assets/968a0496-ffde-402a-98d7-1d672b2bee8e)

[Tab 3. 검색 기능](https://github.com/user-attachments/assets/11f47840-2079-475d-894b-7478c5b74108)

### 5-1. 모든 페이지에서 사용 가능한 검색 기능

- `FocusNode`를 사용하여 검색 페이지에 들어가면 **자동으로 키보드 활성화**
- 키보드의 **완료(엔터) 버튼**이나 검색 버튼을 클릭하면 `searchRestaurants()`가 호출되어 검색 결과를 필터링
- **뒤로 가기 버튼**을 누르면 검색 결과 초기화와 함께 원래 페이지로 되돌아감.

# 개발 후기

### 김대영 

> 첫 주차인만큼 긴장했지만, 정말 좋은 팀원을 만나 별다른 문제없이 끝낼 수 있었던 것 같습니다. 제가 프로젝트를 이끌어가보는 것은 처음인데, 정말 좋은 경험이였습니다. 앞으로도 열심히 하겠습니다!
> 

### 최연우 

> 첫 프로젝트에 너무 좋은 팀메를 만나서 정말 많이 배우고 성장했습니다. 안드로이드 스튜디오를 설치하는 것부터 시작했던 제가 이렇게 하나의 어플을 만들어 냈다는 사실이 너무 감격스러워요🥹 디자인 패턴부터 GitHub 사용 방법, 앱 개발 과정, UI 디자인의 중요성 등등 나열하기 어려울만큼 많이 배웠습니다. 너무 재밌었어요ㅎㅎ 하다보니 욕심이 나서 더욱 더 열심히 했지만, 아쉬운 점도 많습니다. 아쉬운 부분은 앞으로의 프로젝트에서 더욱 보완해가려고 합니다! 고생 많았다, 우리!!
> 

# APK

### [몰입캠프 1주차 결과물 : K-밥심 APK 링크(드라이브)](https://drive.google.com/file/d/1xMsultFVEI1y8smuaOnttTTe9vUBIJdC/view?usp=sharing)
