import { FilterQuery } from 'mongoose';
import { CallType } from '../call-type.schema';


export interface CallTypeFilterDto extends FilterQuery<CallType> { }
