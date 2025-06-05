import Component from "@ember/component";
import { classNames } from "@ember-decorators/component";
import CategoriesTagColumn from "../../components/categories-tag-column";

@classNames("extra-categories-column-outlet", "tag-column")
export default class TagColumn extends Component {
  <template><CategoriesTagColumn /></template>
}
