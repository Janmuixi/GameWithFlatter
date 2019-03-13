
const double kEnemyInitialSpeed = 200.0;
const double kEnemySize = 40.0;

const double kBulletSpeed = 250.0;
const double KBulletRotateAngle = 10.0;
const double kBulletWidth = 27.5;
const double kBulletHeight = 21.25;

const double kRestartGameButtonSize = 40.0;
const double kPauseButtonSize = 40.0;

const double kInitialCreationTime = 4.0;

const String kImgPath = "assets/images/";
const String kAudioPath = "assets/audio/";

int score = 0;
int highScore = 0;

List<String> mochiAssets = ['air_mochi.png', 'alien_mochi.png', 'basic_mochi.png',
'blaze_mochi.png', 'heartless_mochi.png'];

bool gameOver;
bool pause;