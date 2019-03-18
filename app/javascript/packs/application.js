import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from 'activestorage';
import 'bootstrap/dist/css/bootstrap.min.css';

import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
