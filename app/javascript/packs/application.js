import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from 'activestorage';

import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
