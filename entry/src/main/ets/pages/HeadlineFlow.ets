import { NewsItem } from './NewsItem';

@Component
export struct HeadlineFlow {
  @Consume('pageStack') pageStack: NavPathStack;
  @State currentIndex: number = 0;
  @State title: string = '';
  context: UIContext = this.getUIContext();
  private newsData: NewsItem[] = [
    {
      id: 1,
      title: 'HarmonyOS Next Achieves 15 Million Daily Active Users in First Month',
      imageUrl: $r('app.media.image1'),
      time: '9:19 AM'
    },
    {
      id: 2,
      title: 'HarmonyOS Next Security Features Set New Industry Standards',
      imageUrl: $r('app.media.image2'),
      time: '8:45 AM'
    },
    {
      id: 3,
      title: 'Huawei Unveils Next-Gen Wearables Powered by HarmonyOS Next',
      imageUrl: $r('app.media.image3'),
      time: '7:30 AM'
    }
  ];

  build() {
    NavDestination() {
      Stack() {
        Swiper() {
          ForEach(
            this.newsData,
            (item: NewsItem) => {
              this.NewsCard(item)
            },
            (item: NewsItem) => item.title
          )
        }
        .index(this.currentIndex)
        .indicator(true)
        .loop(true)
        .vertical(false)
        .onChange((index: number) => {
          this.currentIndex = index;
        })
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
      const params = ctx.pathInfo.param as string;
      if (params) {
        this.title = params;
      }
    })
    .backgroundColor(Color.Black)
    .hideBackButton(true)
  }

  @Builder
  NewsCard(item: NewsItem): void {
    Stack({ alignContent: Alignment.Bottom }) {
      Image(item.imageUrl)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      Column()
        .width('100%')
        .height('60%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [0x0D000000, 0.0],
            [0x00000000, 0.6],
            [0x00000000, 1.0]
          ]
        })

      Column({ space: 8 }) {
        Text(item.title)
          .fontSize(20)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .maxLines(5)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight(26)
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ left: 15, right: 15, bottom: 25 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}