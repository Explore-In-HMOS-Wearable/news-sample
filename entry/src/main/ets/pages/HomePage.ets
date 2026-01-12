import { ArcList, ComponentContent } from '@kit.ArkUI';
import { Pages } from './Pages';

@Component
export struct HomePage {
  @Consume('pageStack') pageStack: NavPathStack;
  context: UIContext = this.getUIContext()
  tabBar1: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(header));

  @State headers: String[] = [
    'Top News', 'Sports', 'Economics', 'Sky News'
  ];

  build() {
    NavDestination() {
      ArcList({ header: this.tabBar1 }) {
        ForEach(
          this.headers,
          (item: string) => {
            Headline({
              title: item,
              onNavigate: () => {
                this.pageStack.pushPathByName(Pages.HeadlineFlow, item)
              }
            })
          },
          (item: string) => item
        )
      }
    }
    .onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
    .backgroundColor($r('app.color.bgColor'))
    .hideBackButton(true)
  }
}

@Builder
function header() {
  Column() {
    Text('Headlines')
      .fontSize('45px')
      .fontWeight(FontWeight.Bold)
  }.margin(0)
}

export interface HeaderItemData {
  title: string;
  icon: Resource;
}

@Component
struct Headline {
  @Prop title: string;
  onNavigate?: () => void

  build() {
    Row() {
      Text(this.title)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('90%')
        .textAlign(TextAlign.Start)
        .fontSize(16)
    }
    .backgroundColor($r('app.color.backgroundColor'))
    .borderRadius(25)
    .margin(5)
    .width('85%')
    .padding({
      top: 6,
      bottom: 6,
      left: 8,
      right: 8
    })
    .onClick(() => {
      if (this.onNavigate) {
        this.onNavigate()
      }
    });
  }
}