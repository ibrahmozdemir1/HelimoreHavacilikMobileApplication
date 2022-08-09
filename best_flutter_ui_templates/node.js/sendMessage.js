const { messaging } = require("firebase-admin");
const admin  = require("firebase-admin");
const serviceAccount = require("./service-account-file.json");
const DB_URL = "https://resimkaydet-74b21-default-rtdb.firebaseio.com";
const fs = require("@google-cloud/firestore");




admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: DB_URL
});

db = admin.firestore();

async function getFireStore(){
       
        const data = await db.collection('bileklik').get()
        const citiesRef = db.collection('sirket').get();
        if(data.empty)
            {
                return -1
            }
        else {
            
            data.forEach((doc) => {
                var kalpAtis = doc.data()['kalpAtisHizi'];
                var sirketId = doc.data()['sirketID'];
                if(kalpAtis >= 120 || kalpAtis <= 40){
                    var isim = doc.data()['kisiAdi'];
                    citiesRef.then((snapshot) => {
                        snapshot.forEach((docs) => {
                            var sirket = docs.data()['sirketID']; 
                            if(sirket == sirketId){
                              deviceToken = docs.data()['sirketDeviceToken'];
                              if(deviceToken != ""){
                                sendNotification(deviceToken,isim);
                              }
                    
                            }
                        })
        
                    })       
                }      
                    
            });
        }
}


async function sendNotification(tokens,isim){
    var deviceToken = tokens;
    try{       
        const message = {
            notification: {
                title: 'UYARI',
                body: isim + ' ' + 'kişisinin kalp hızı anormal bir şekilde ilerliyor.'
            },
            data: {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "id": "1",
                "status": "done",
            },
       
          
            token: deviceToken
        };

        admin.messaging().send(message).then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
          })
          .catch((error) => {
            console.log('Error sending message:', error);
          });


    } catch (error) {
        console.log(error);
    }

}

getFireStore();
