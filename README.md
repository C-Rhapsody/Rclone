# Rclone Cache

## Intro : Plexdrive vs Rclone

기존에 plexdrive(4, 5 포함)를 사용하다보니 chunk 관련된 오류와 함께 업로드된 파일이 반영이 안되거나 

  - 그럴때마다 plexdrive binary를 재시작하거나 시스템 재부팅
  - 추측키론 개인적으로 plexmediaserver에 사용할 영상파일 등과 더불어 업무파일 백업, 개인적인 유틸리티 저장 등을 더불어하여 꽤 많은 폴더와 파일들이 생성되어 한계에 도달하였다 판단함.
  - 이에, 구글드라이브 root내 모든 디렉토리가 아니라 특정 디렉토리를 root로 지정하여 Reading하는 양을 줄이거나, 한계가 더 높은 binary가 필요하다 예상함
  - 그러던 중, 반갑게도 Rclone 1.38? 1.39?부터 Rclone에도 Plexmediaserver를 위한 Cache 기능이 활성화되었단 이야기를 한 네이버카페에서 발견함
  - 이에 Rclone Cache를 기준으로 Plexmediaserver 구성하는 테스트를 여러번 시도
    - Rclone은 Config 내용 중에 RootDirectory를 선택하던 옵션이 있었던 것으로 기억
    - DB는 어떤 DB를 사용하는지(plexdrive의 경우 4.0은 외부종속으로 MongoDB, 5.0은 golang이 기초인 boltdb) 자세히 모르겠으나 plexdriver 5처럼 내부 DB를 사용하는 것으로 보임
    
## History : 삽질기

  - 큰 오해를 했던 부분이 Rclone config 구성시 Cache config를 추가해 주면 구글드라이브를 구성했던 config에 반영되는지 알고 일반 Config의 Name을 Mount해서 계속 테스트하였음
  - 희안하게 Plexmediaserver에서 에이전트를 TVDB 또는 TMDB로 구성하면 Banned 되기까지 상당히 오랜 시간이 걸려서 '아직 Rclone Cache 기능이 완벽하지 않은가 보다' 라고 생각하고 계속 다음버전을 기약하였음
  - 그렇게 몇 달의 시간이 걸리고..... 여러번 Ban과 더불어 더이상 귀찮아 지기 시작할 때, '내가 큰 오해를 하고 있는건 아닐까???' 싶어 열심히 구글링 하였음
  - 그러나 Cache Mount에 대한 Sample은 확인하지 못하였고, 그냥 한 번 해보자는 심정으로 Cache Config한 Name을 Mount해 보았음.
  - 그 이후에는 plexdrive처럼 Ban 되지 않고 plexmediaserver Library 구성이 잘 되었음 -_-;;;
    - 이 때 버전이 Rclone 1.41 이었나....1.42였나....
  - 그리고 얼마의 시간이 지난지 모르겠으나, Ban 없이 잘 사용중 -_- 
    - Rclone은 확인될 때마다 Update하였고(글 작성하는 현재 시점에 1.44? 1.45?) plexmediaserver도 계속 Update하였으나 큰 이슈 없음

## After : Todo
  
  - Rclone Cache : 인연이 된다면 다른 Cloud도 한 번 구성해 볼까 한다.(가능성은 현저히 낮아 보임)
  - Rclone Move / Copy : Google에서 하루 한계치인 750G를 우회하는 방법을 찾는 중
 
