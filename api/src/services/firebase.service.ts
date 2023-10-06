import { Injectable } from '@nestjs/common';
import FirebaseAdmin from 'firebase-admin';
import { FirebaseConfig } from 'src/common/firebase-admin-sdk.config';
import { Message, TopicMessage } from 'firebase-admin/lib/messaging/messaging-api';
@Injectable()
export class FirebaseService {
    constructor() {
        FirebaseAdmin.initializeApp({
            credential: FirebaseAdmin.credential.cert({
                clientEmail: FirebaseConfig.client_email,
                projectId: FirebaseConfig.project_id,
                privateKey: FirebaseConfig.private_key,
            }),
        });
    }
    async firebaseMessaging(messages: Message[]) {
        const response = await FirebaseAdmin.messaging().sendEach(messages)

        return {
            successCount: response.successCount,
            failCount: response.failureCount,
        };
    }
}
