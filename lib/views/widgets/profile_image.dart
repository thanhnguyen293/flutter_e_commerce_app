import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controller/user_repository.dart';
import '../../themes/light_color.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<DocumentSnapshot>(
        future: UserRepository().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircleAvatar(
              radius: 60,
              backgroundColor: LightColor.kPrimaryLightColor,
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return data['imageUrl'] != null
                ? CircleAvatar(
                    backgroundColor: LightColor.kPrimaryLightColor,
                    radius: 60,
                    backgroundImage: NetworkImage(
                      snapshot.data!['imageUrl'],
                    ),
                  )
                : const CircleAvatar(
                    backgroundColor: LightColor.kPrimaryLightColor,
                    radius: 60,
                    child: Icon(
                      Icons.person,
                      size: 60,
                    ),
                  );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
