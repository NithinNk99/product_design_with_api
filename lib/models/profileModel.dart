class profileModel {
  final String imagePath;
  final String profileNamePath;

  profileModel({required this.imagePath, required this.profileNamePath});
}

List<profileModel> profileList = [
  profileModel(
    imagePath: 'https://randomuser.me/api/portraits/men/42.jpg',
    profileNamePath: 'Kingsly',
  ),
  profileModel(
    imagePath: 'https://randomuser.me/api/portraits/men/49.jpg',
    profileNamePath: 'Rockerty',
  ),
  profileModel(
    imagePath: 'https://randomuser.me/api/portraits/women/67.jpg',
    profileNamePath: 'M Jane',
  ),
  profileModel(
    imagePath: 'https://randomuser.me/api/portraits/women/85.jpg',
    profileNamePath: 'experole',
  ),
  profileModel(
    imagePath: 'https://randomuser.me/api/portraits/women/82.jpg',
    profileNamePath: 'vineyare y',
  ),
  profileModel(
    imagePath: 'https://randomuser.me/api/portraits/women/81.jpg',
    profileNamePath: 'Shilpa',
  ),
  profileModel(
    imagePath: 'https://randomuser.me/api/portraits/women/89.jpg',
    profileNamePath: 'Hancherika',
  ),
];
