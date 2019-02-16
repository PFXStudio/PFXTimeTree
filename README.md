# PFXTimeTree

### 프로젝트 설명
* 폴더 별 파일순서로 설명 기재


### UIView+Custom.h
* UIView의 쉐도우 및 라운딩을 위한 클래스


### DefineStrings.swift
* 고정 문자열 모음 파일


### ExtensionDateFormatter.swift
* mock.json에서 제공되고 있는 시간 정보 포맷을 맞추기 위한 DateFormatter 확장 클래스


### EventManager.swift
* 이벤트 정보 관리 클래스이며 이벤트 추가, 충돌체크, 노티피케이션 제공


### EventModel.swift
* mock.json 정보 구조체


### Localizable.strings
* 다국어 파일


### mock.json
* 이벤트 정보 파일


### PFXTimeTree-Bridging-Header.h
* Objective-C 브릿지 헤더 파일


### DefaultTheme.swift
* 색상, 라운드, 그림자 정보 파일


### MainViewController.swift
* 달력 뷰 클래스
* CVCalendar 오픈 소스를 활용
* 이벤트가 있는 날짜는 동그라미가 그려 짐
* 날짜를 선택하면 해당 날짜의 이벤트 정보가 보여 짐


### EventViewController.swift
* 이벤트 정보 뷰 클래스


### EventTableViewController.swift
* 이벤트 정보 리스팅 클래스
* 중복되는 이벤트 정보는 빨간색으로 표기


### EventTableViewCell.swift
* 이벤트 정보 셀 클래스


### EventRegistViewController.swift
* 이벤트 등록 뷰 클래스
