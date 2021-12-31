class FirestorePath {
  static String todo(String uid, String todoId) => 'users/$uid/todos/$todoId';
  static String customer(String uid, String nameColection) =>
      'users/$uid/$nameColection';
}
///users/LbfFG7xoUhP1ofTPrrHXYq0kCoi2/customer/7tEmQ8TnfyVQ5y