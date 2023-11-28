import { FilterQuery } from 'mongoose';
import { Call } from '../call.schema';


export interface CallFilterDto extends FilterQuery<Call> { }
