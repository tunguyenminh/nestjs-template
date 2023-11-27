import { FilterQuery } from 'mongoose';

import { User } from '../user.schema';

export interface UserFilterDto extends FilterQuery<User> { }
