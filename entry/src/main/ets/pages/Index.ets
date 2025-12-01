import { HeadlineFlow } from './HeadlineFlow';
import { HomePage } from './HomePage';
import { Pages } from './Pages';

@Entry
@Component
struct Index {
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack();

  @Builder
  Pages(name: string) {
    if (name === Pages.HomePage) {
      HomePage();
    }
    if (name === Pages.HeadlineFlow) {
      HeadlineFlow();
    }
  }

  build() {
    Navigation(this.pageStack)
      .mode(NavigationMode.Stack)
      .navDestination(this.Pages)
      .hideNavBar(true)
      .onAppear(() => {
        if (this.pageStack.getAllPathName().length === 0) {
          this.pageStack.pushPathByName('HomePage', null);
        }
      })
  }
}