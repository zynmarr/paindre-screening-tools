part of 'core.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'welcome': 'Welcome to Paindre Screening Tools',
      'appName': 'Paindre Screening Tools',
      'appDescription': 'A tool for screening pain and other conditions',
      'appVersion': 'Version 1.0.0',

      'yes': 'Yes',
      'no': 'No',
      'cancel': 'Cancel',
      'ok': 'OK',
      'close': 'Close',
      'delete': 'Delete',
      'next': 'Next',
      'exit': 'Exit',

      'form.patient.header': 'Patient Information',

      ...buttons['en']!,
      ...forms['en']!,
      ...hints['en']!,
      ...validations['en']!,
      ...dialogs['en']!,
      ...informDataPatient['en']!,
      ...texts['en']!,
      ...successMessage['en']!,
      ...errorsMessage['en']!,

      'patientData': 'Patient Data',
      'screeningData': 'Screening Data',

      'empty': 'Empty',
      'years': 'Years',
      'title.detailExamination': 'Detail Examination',

      'language': 'Language',
      'settings': 'Settings',

      'man': 'Male',
      'woman': 'Female',

      'select.gender': 'Please Select Gender',

      'pain.nociceptive': 'Nociceptive Pain',
      'pain.neuropathic': 'Neuropathic Pain',
      'pain.centralSensitization': 'Central Sensitization Pain',

      'questions.type.1': 'Subjective Examination',
      'questions.type.2': 'Physical examination',

      ...questions['en']!,
    },
    'id': {
      'welcome': 'Selamat datang di Paindre Screening Tools',
      'appName': 'Paindre Screening Tools',
      'appDescription': 'Alat untuk skrining nyeri dan kondisi lainnya',
      'appVersion': 'Versi 1.0.0',

      'yes': 'Ya',
      'no': 'Tidak',
      'cancel': 'Batal',
      'ok': 'OK',
      'close': 'Tutup',
      'delete': 'Hapus',
      'next': 'Selanjutnya',
      'exit': 'Keluar',

      'form.patient.header': 'Informasi Pasien',

      ...buttons['id']!,
      ...forms['id']!,
      ...hints['id']!,
      ...validations['id']!,
      ...dialogs['id']!,
      ...informDataPatient['id']!,
      ...texts['id'],
      ...successMessage['id']!,
      ...errorsMessage['id']!,

      'patientData': 'Data Pasien',
      'screeningData': 'Data Skrining',
      'empty': 'Kosong',
      'years': 'Tahun',

      'title.detailExamination': 'Detail Pemeriksaan',

      'language': 'Bahasa',
      'settings': 'Pengaturan',

      'man': 'Laki-laki',
      'woman': 'Perempuan',
      'select.gender': 'Pilih jenis kelamin',

      'pain.nociceptive': 'Nyeri Nosiseptif',
      'pain.neuropathic': 'Nyeri Neuropatik',
      'pain.centralSensitization': 'Nyeri Sensitisasi Sentral',

      'questions.type.1': 'Pemeriksaan Subjektif',
      'questions.type.2': 'Pemeriksaan Fisik',

      ...questions['id']!,
    },
  };
}

Map texts = {
  'en': {
    'text.welcomeInLogin': 'Welcome,',
    'text.loginFirst': 'Please login first to continue',

    'text.headline.register.1': 'Don\'t have an account?',
    'text.headline.register.2': 'Please register your account here',

    'text.dontHaveAccount': 'Don\'t have an account?',
    'text.haveAccount': 'Already have an account?',
    'text.painResultData': 'No specific pain found, please re-examine again.',
    'text.resultIs': 'The examination result is ',
    'text.resultIsNot': 'The examination result is not ',
    'text.allResultExamination': 'The results of all your examinations are suffering from:',
    'text.lastResultxamination': 'Last Examination Result',
  },
  'id': {
    'text.welcomeInLogin': 'Selamat Datang,',
    'text.loginFirst': 'Silakan masuk terlebih dahulu',

    'text.headline.register.1': 'Belum Punya Akun?',
    'text.headline.register.2': 'Silahkan daftar akun anda disini',

    'text.dontHaveAccount': 'Belum punya akun?',
    'text.haveAccount': 'Sudah punya akun?',
    'text.painResultData': 'Tidak ditemukan nyeri specifik, mohon lakukan pemeriksaan ulang kembali.',
    'text.resultIs': 'Hasil pemeriksaan adalah ',
    'text.resultIsNot': 'Hasil pemeriksaan bukan ',
    'text.allResultExamination': 'Hasil semua pemeriksaan anda menderita:',
    'text.lastResultxamination': 'Hasil Pemeriksaan Akhir',
  },
};

Map informDataPatient = {
  'en': {
    'name': 'Name',
    'age': 'Age',
    'email': 'Email',
    'password': 'Password',
    'phone': 'Phone',
    'diagnosis': 'Diagnosis',
    'gender': 'Gender',
    'examinerName': 'Examiner',
    'dateExamined': 'Date Examined',
    'checkUpResult': 'Check Up Result',
  },
  'id': {
    'name': 'Nama',
    'age': 'Usia',
    'email': 'Email',
    'password': 'Kata Sandi',
    'phone': 'Telepon',
    'diagnosis': 'Diagnosa',
    'gender': 'Jenis Kelamin',
    'examinerName': 'Pemeriksa',
    'dateExamined': 'Tanggal Pemeriksaan',
    'checkUpResult': 'Hasil Pemeriksaan',
  },
};

Map buttons = {
  'en': {
    'button.screeningData': 'Screening Data',
    'button.patientData': 'Patient Data',
    'button.startScreening': 'Start Screening',
    'button.checkResult': 'Check Result',
    'button.save': 'Save',
    'button.login': 'Login',
    'button.register': 'Register',
    'button.logout': 'Logout',
    'text.loginWithGoogle': 'Login with Google',
  },
  'id': {
    'button.screeningData': 'Data Skrining',
    'button.patientData': 'Data Pasien',
    'button.startScreening': 'Mulai Skrining',
    'button.checkResult': 'Periksa Hasil',
    'button.save': 'Simpan',
    'button.login': 'Masuk',
    'button.register': 'Daftar',
    'button.logout': 'Keluar',
    'text.loginWithGoogle': 'Masuk dengan Google',
  },
};

Map forms = {
  'en': {
    'form.patient.name': 'Full Name',
    'form.patient.age': 'Age',
    'form.patient.phone': 'Phone Number (Optional)',
    'form.patient.diagnosis': 'Diagnosis (Optional)',
    'form.patient.examinerName': 'Examiner Name',
    'form.patient.gender': 'Gender',
  },
  'id': {
    'form.patient.name': 'Nama Lengkap',
    'form.patient.age': 'Usia',
    'form.patient.phone': 'Nomor Telepon (Opsional)',
    'form.patient.diagnosis': 'Diagnosa (Opsional)',
    'form.patient.examinerName': 'Nama Pemeriksa',
    'form.patient.gender': 'Jenis Kelamin',
  },
};

Map hints = {
  'en': {
    'hint.name': 'Enter full name',
    'hint.age': 'Enter age',
    'hint.email': 'Enter email address',
    'hint.diagnosis': 'Enter diagnosis',
    'hint.phone': 'Enter phone number (optional)',
    'hint.examinerName': 'Enter examiner name',
    'hint.password': 'Enter password',
  },
  'id': {
    'hint.name': 'Masukkan nama lengkap',
    'hint.age': 'Masukkan usia',
    'hint.email': 'Masukkan alamat surel',
    'hint.diagnosis': 'Masukkan diagnosa',
    'hint.phone': 'Masukkan nomor telepon (opsional)',
    'hint.examinerName': 'Masukkan nama pemeriksa',
    'hint.password': 'Masukkan kata sandi',
  },
};

Map validations = {
  'en': {
    'validation.required': 'This field is required',
    'validation.invalidEmail': 'Invalid email address',
    'validation.name.required': 'Name is required',
    'validation.email.required': 'Email is required',
    'validation.password.required': 'Password is required',
    'validation.password.minLength': 'Password must be at least 6 characters long',
  },
  'id': {
    'validation.required': 'Kolom ini harus diisi',
    'validation.invalidEmail': 'Alamat email tidak valid',
    'validation.name.required': 'Nama harus diisi',
    'validation.email.required': 'Email harus diisi',
    'validation.password.required': 'Password harus diisi',
    'validation.password.minLength': 'Password harus terdiri dari minimal 6 karakter',
  },
};

Map dialogs = {
  'en': {
    'dialog.title': 'Notification',
    'dialog.sure': 'Are you sure?',
    'dialog.save': 'Are you sure you want to save this data?',
    'dialog.delete': 'Are you sure you want to delete this data?',
    'dialog.exit': 'Are you sure you want to exit the application?',
    'dialog.exitPage': 'Are you sure you want to exit this page?',
  },
  'id': {
    'dialog.title': 'Pemberitahuan',
    'dialog.sure': 'Apakah Anda sudah yakin?',
    'dialog.save': 'Apakah Anda yakin menyimpan data ini?',
    'dialog.delete': 'Apakah Anda yakin menghapus data ini?',
    'dialog.exit': 'Apakah Anda yakin ingin keluar dari aplikasi?',
    'dialog.exitPage': 'Apakah Anda yakin ingin keluar dari halaman ini?',
  },
};

//map success messages
Map successMessage = {
  'en': {
    'success.message.login': 'Login successful!',
    'success.message.register': 'Registration successful! Please login to continue.',
    'success.message.save': 'Data saved successfully!',
    'success.message.logout': 'Logout successful!',
    'success.message.delete': 'Data deleted successfully!',
  },
  'id': {
    'success.message.login': 'Masuk berhasil!',
    'success.message.register': 'Pendaftaran berhasil! Silakan masuk untuk melanjutkan.',
    'success.message.save': 'Data berhasil disimpan!',
    'success.message.logout': 'Keluar berhasil!',
    'success.message.delete': 'Data berhasil dihapus!',
  },
};

//map error
Map errorsMessage = {
  'en': {
    'error.message.login': 'Login failed: ',
    'error.message.loginWithGoogle': 'Login with Google failed: ',
    'error.message.register': 'Registration failed: ',
    'error.message.whenRegister': 'There something error when registering',
    'error.message.emailAlreadyInUse': 'Email already in use, please login',
    'error.message.whenLogin': 'There something error when logging in',
    'error.message.save': 'Failed to save data: ',
    'error.message.logout': 'Failed to logout: ',
    'error.message.delete': 'Failed to delete data: ',

    'error.message.userNotFound': 'User not found, please check your email',
    'error.message.wrongPassword': 'The password you entered is incorrect, please try again',
    'error.message.invalidEmail': 'The email you entered is invalid, please check again',
    'error.message.credentialInvalid': 'Invalid credentials, please check your email and password',
    'error.message.emailNotVerified': 'Email not verified, please check your email for verification link',

    'error.message.network': 'Network error, please check your connection',
    'error.message.unknown': 'An unknown error occurred, please try again later',
    'error.message.invalidData': 'Invalid data provided, please check your input',
    'error.message.dataNotFound': 'Data not found, please check your input or try again later',
  },
  'id': {
    'error.message.login': 'Masuk gagal: ',
    'error.message.loginWithGoogle': 'Masuk dengan Google gagal: ',
    'error.message.register': 'Pendaftaran gagal: ',
    'error.message.whenRegister': 'Terjadi kesalahan saat pendaftaran',
    'error.message.emailAlreadyInUse': 'Email sudah terdaftar, silakan masuk',
    'error.message.whenLogin': 'Terjadi kesalahan saat masuk',
    'error.message.save': 'Gagal menyimpan data: ',
    'error.message.logout': 'Gagal keluar: ',
    'error.message.delete': 'Gagal menghapus data: ',

    'error.message.userNotFound': 'Pengguna tidak ditemukan, silakan periksa email Anda',
    'error.message.wrongPassword': 'Password yang Anda masukkan salah, silakan coba lagi',
    'error.message.invalidEmail': 'Email yang Anda masukkan tidak valid, silakan periksa kembali',
    'error.message.credentialInvalid': 'Kredensial tidak valid, silakan periksa email dan kata sandi Anda',
    'error.message.emailNotVerified': 'Email belum diverifikasi, silakan periksa email Anda untuk tautan verifikasi',

    'error.message.network': 'Kesalahan jaringan, silakan periksa koneksi Anda',
    'error.message.unknown': 'Terjadi kesalahan yang tidak diketahui, silakan coba lagi nanti',
    'error.message.invalidData': 'Data yang diberikan tidak valid, silakan periksa input Anda',
    'error.message.dataNotFound': 'Data tidak ditemukan, silakan periksa input Anda atau coba lagi nanti',
  },
};

Map<String, Map<String, String>> questions = {
  'en': {
    'questions.nociceptive.1.title': 'Knowing factors that can worsen and relieve pain',
    'questions.nociceptive.1.subtitle': 'Are there things that can worsen or relieve the pain you feel?',

    'questions.nociceptive.2.title': 'The pain is related to a history of trauma or postural dysfunction',
    'questions.nociceptive.2.subtitle': 'Is the pain you feel caused by a previous trauma or injury?',

    'questions.nociceptive.3.title': 'The pain is localized to the injured area',
    'questions.nociceptive.3.subtitle': 'Is the pain you feel only in the area of the injury?',

    'questions.nociceptive.4.title': 'The healing process of pain occurs according to the tissue healing time',
    'questions.nociceptive.4.subtitle': 'Have you ever had an injury at the location of your current pain?',

    'questions.nociceptive.5.title': 'The healing process of pain occurs according to the tissue healing time',
    'questions.nociceptive.5.subtitle': 'If so, does the pain go away after your injury heals?',

    'questions.nociceptive.6.title': 'Pain responds to analgesics/NSAIDs',
    'questions.nociceptive.6.subtitle': 'Does your pain decrease after taking pain medications (paracetamol, NSAIDs, etc.)?',

    'questions.nociceptive.7.title': 'Movement/mechanical stimulation causes sharp and transient pain',
    'questions.nociceptive.7.subtitle': 'Do you feel sharp pain when performing a movement that lasts only for a moment?',

    'questions.nociceptive.8.title': 'Pain is associated with inflammatory symptoms (such as swelling, redness, and heat)',
    'questions.nociceptive.8.subtitle': 'Is there swelling, redness, and warmth at the location of your pain?',

    'questions.nociceptive.9.title': 'Pain has recently arisen',
    'questions.nociceptive.9.subtitle': 'Has the pain you feel lasted for a short time (less than 3 months)?',

    // Physical examination
    'questions.nociceptive.10.title': 'During movement, the pain felt is clear and anatomically appropriate',
    'questions.nociceptive.10.subtitle': '',

    'questions.nociceptive.11.title': 'On palpation, localized pressure pain is felt at the injury site',
    'questions.nociceptive.11.subtitle': '',

    // Neuropathic Pain Questions
    'questions.neuropathic.1.title': 'Pain feels like burning, sharp, electric shock, or stabbing',
    'questions.neuropathic.1.subtitle': 'Do you feel pain like burning, sharp, electric shock, or stabbing sensation?',

    'questions.neuropathic.2.title': 'Pain is caused by a history of mechanical or pathological injury',
    'questions.neuropathic.2.subtitle': 'Have you ever experienced an injury or wound to the nerve before?',

    'questions.neuropathic.3.title': 'Pain is caused by a history of mechanical or pathological injury',
    'questions.neuropathic.3.subtitle': 'Is the pain you feel accompanied by numbness, tingling, and a thick sensation?',

    'questions.neuropathic.4.title': 'Pain responds slightly to analgesics/NSAIDs and more to anticonvulsants or antidepressants',
    'questions.neuropathic.4.subtitle': 'Do medications like paracetamol and NSAIDs significantly reduce your pain?',

    'questions.neuropathic.5.title': 'If stimulated, it takes a long time for the pain to subside',
    'questions.neuropathic.5.subtitle': 'If there is an action that causes pain in your body, does it take a long time for the pain to go away?',

    'questions.neuropathic.6.title':
        'There is a mechanical pattern to factors that worsen and relieve pain, including activities/postures related to movement or compression on nerve tissue',
    'questions.neuropathic.6.subtitle':
        'Are there certain movements, such as standing upright, bending forward or backward, twisting the waist, or moving the waist left and right, that can worsen or relieve the pain you feel?',

    'questions.neuropathic.7.title': 'Pain is associated with dysesthesia symptoms (such as itching or feeling like something is crawling)',
    'questions.neuropathic.7.subtitle': 'Does the pain you feel feel itchy or like something is crawling?',

    'questions.neuropathic.8.title': 'Pain occurs spontaneously and worsens',
    'questions.neuropathic.8.subtitle': 'Does your pain feel worse when you are sad, angry, stressed, or having problems with others?',

    // Physical examination
    'questions.neuropathic.9.title':
        'Pain worsens with movement tests, including active/passive movements, neurodynamic tests with SLR and Plexus Brachialis tests',
    'questions.neuropathic.9.subtitle': '',

    'questions.neuropathic.10.title': 'Pain arises with palpation of the injured nerve tissue',
    'questions.neuropathic.10.subtitle': '',

    'questions.neuropathic.11.title':
        'Neurological examination shows reflex disturbances, decreased sensation, and muscle strength distributed dermatomally',
    'questions.neuropathic.11.subtitle': '',

    'questions.neuropathic.12.title': 'The presence of antalgic movement',
    'questions.neuropathic.12.subtitle': '',

    'questions.neuropathic.13.title': 'The presence of hyperalgesia or allodynia',
    'questions.neuropathic.13.subtitle': '',

    // Central Sensitization Pain Questions
    'questions.central.1.title': 'Inconsistency between the pain felt and the activities performed',
    'questions.central.1.subtitle': 'Do you feel pain when performing light movements?',

    'questions.central.2.title': 'Pain is not influenced by mechanical factors (load)',
    'questions.central.2.subtitle': 'Do you feel pain even when not performing any movement?',

    'questions.central.3.title': 'Pain that occurs cannot be predicted in pattern against provocations performed',
    'questions.central.3.subtitle': 'Can you feel pain that arises at any time?',

    'questions.central.4.title': 'Pain persists beyond the tissue healing time',
    'questions.central.4.subtitle': 'Is the pain still felt even though the injury you experienced has healed?',

    'questions.central.5.title': 'Pain felt is disproportionate to the nature or pathology of the injury',
    'questions.central.5.subtitle': 'Do you feel severe pain in a condition of light injury?',

    'questions.central.6.title': 'Pain felt is widely distributed and not anatomically appropriate',
    'questions.central.6.subtitle': 'Do you feel pain in many or almost all parts of your body?',

    'questions.central.7.title':
        'Pain is associated with psychosocial disturbances (such as negative emotions, lack of self-confidence, problems in family/work/environment relationships)',
    'questions.central.7.subtitle': 'Does your pain feel worse when you are sad, angry, stressed, or having problems with others?',

    'questions.central.8.title':
        'Administration of analgesics/NSAIDs does not produce the expected response and/or administration of antiepileptics (such as Gabapentin, Pregabalin)/antidepressants (such as Amitriptyline) is better in reducing pain',
    'questions.central.8.subtitle': '',

    'questions.central.9.title': 'Pain felt is related to functional disability',
    'questions.central.9.subtitle': 'Does pain interfere with all your activities?',

    'questions.central.10.title': 'Pain arises at night causing sleep disturbances',
    'questions.central.10.subtitle': 'Does pain disturb your sleep?',

    'questions.central.11.title': 'Pain felt is associated with dysesthesia symptoms (such as cold, crawling, or feeling like something is crawling)',
    'questions.central.11.subtitle': 'Does your pain feel cold, crawling, or like something is crawling?',

    'questions.central.12.title': 'If pain is stimulated, it takes a long time for the pain to subside',
    'questions.central.12.subtitle': 'Does your pain easily occur and take a long time to go away?',

    // Physical examination
    'questions.central.13.title': 'Movement tests can cause disproportionate pain',
    'questions.central.13.subtitle': '',

    'questions.central.14.title': 'Movement tests can cause inconsistent pain',
    'questions.central.14.subtitle': '',

    'questions.central.15.title': 'Movement tests can cause non-mechanical or non-anatomical pain',
    'questions.central.15.subtitle': '',

    'questions.central.16.title': 'Hyperalgesia (primary, secondary)',
    'questions.central.16.subtitle': '',

    'questions.central.17.title': 'Allodynia',
    'questions.central.17.subtitle': '',

    'questions.central.18.title': 'Hyperpathy',
    'questions.central.18.subtitle': '',
  },
  'id': {
    'questions.nociceptive.1.title': 'Mengetahui faktor yang dapat memperberat dan meringankan nyeri',
    'questions.nociceptive.1.subtitle': 'Apakah ada hal-hal yang dapat memperberat atau memperingan nyeri yang Anda rasakan?',

    'questions.nociceptive.2.title': 'Nyeri yang dirasakan berkaitan dengan riwayat trauma atau disfungsi postural',
    'questions.nociceptive.2.subtitle': 'Apakah nyeri yang Anda rasakan disebabkan oleh adanya trauma atau luka sebelumnya?',

    'questions.nociceptive.3.title': 'Nyeri yang dirasakan terlokalisir pada daerah cedera',
    'questions.nociceptive.3.subtitle': 'Apakah nyeri yang Anda rasakan hanya terasa di daerah luka atau cedera?',

    'questions.nociceptive.4.title': 'Proses penyembuhan nyeri terjadi sesuai dengan waktu penyembuhan jaringan',
    'questions.nociceptive.4.subtitle': 'Apakah Anda pernah mengalami luka di lokasi nyeri Anda saat ini?',

    'questions.nociceptive.5.title': 'Proses penyembuhan nyeri terjadi sesuai dengan waktu penyembuhan jaringan',
    'questions.nociceptive.5.subtitle': 'Bila ada, apakah nyeri yang dirasakan hilang setelah luka Anda sembuh?',

    'questions.nociceptive.6.title': 'Nyeri berespon terhadap analgesik/NSAID',
    'questions.nociceptive.6.subtitle': 'Apakah nyeri Anda berkurang setelah minum obat-obatan anti nyeri?(paracetamol, NSAID, dan lain-lain)',

    'questions.nociceptive.7.title': 'Gerakan/rangsangan mekanis menimbulkan rasa nyeri yang bersifat tajam dan sesaat',
    'questions.nociceptive.7.subtitle': 'Apakah Anda merasakan nyeri tajam saat melakukan suatu gerakan, dan hanya berlangsung sesaat?',

    'questions.nociceptive.8.title': 'Nyeri yang dirasakan berhubungan dengan gejala inflamasi (seperti: bengkak, kemerahan dan panas)',
    'questions.nociceptive.8.subtitle': 'Apakah terdapat bengkak, kemerahan, dan rasa panas pada lokasi nyeri Anda?',

    'questions.nociceptive.9.title': 'Nyeri timbul baru-baru ini',
    'questions.nociceptive.9.subtitle': 'Apakah nyeri yang Anda rasakan berlangsung belum lama?(kurang dari 3 bulan)',

    // Physical examination
    'questions.nociceptive.10.title': 'Pada pergerakan, nyeri yang dirasakan jelas dan sesuai dengan anatomis',
    'questions.nociceptive.10.subtitle': '',

    'questions.nociceptive.11.title': 'Pada palpasi, nyeri tekan dirasakan terlokalisir pada daerah cedera',
    'questions.nociceptive.11.subtitle': '',

    // Neuropathic Pain Questions
    'questions.neuropathic.1.title': 'Nyeri yang dirasakan seperti sensasi terbakar, tajam, tersengat listrik atau tersetrum',
    'questions.neuropathic.1.subtitle': 'Apakah Anda merasakan nyeri seperti sensasi terbakar, tajam, tersengat listrik atau tersetrum?',

    'questions.neuropathic.2.title': 'Nyeri yang dirasakan diakibatkan oleh riwayat cedera secara mekanis atau patologis',
    'questions.neuropathic.2.subtitle': 'Apakah Anda pernah mengalami cidera atau luka pada saraf sebelumnya?',

    'questions.neuropathic.3.title': 'Nyeri yang dirasakan diakibatkan oleh riwayat cedera secara mekanis atau patologis',
    'questions.neuropathic.3.subtitle': 'Apakah nyeri yang Anda rasakan disertai oleh rasa kebas, kesemutan, dan terasa tebal?',

    'questions.neuropathic.4.title':
        'Nyeri yang dirasakan sedikit memberikan respon terhadap analgesik/NSAID dan lebih berespon terhadap anti kejang atau anti depresan',
    'questions.neuropathic.4.subtitle': 'Apakah obat-obatan seperti paracetamol dan NSAID dapat mengurangi nyeri Anda secara signifikan?',

    'questions.neuropathic.5.title': 'Apabila terstimulasi, maka dibutuhkan waktu yang lama untuk nyeri tersebut menghilang',
    'questions.neuropathic.5.subtitle':
        'Apabila ada tindakan yang menimbulkan nyeri di tubuh Anda, apakah dibutuhkan waktu yang lama sampai nyeri tersebut menghilang?',

    'questions.neuropathic.6.title':
        'Adanya pola mekanik terhadap faktor yang memperberat dan meringankan nyeri termasuk aktivitas/postur yang berhubungan dengan gerakan atau kompresi pada jaringan saraf',
    'questions.neuropathic.6.subtitle':
        'Apakah ada gerakan tertentu, seperti berdiri tegak, membungkuk ke depan atau belakang, memutar pinggang, atau menggerakkan pinggang ke kiri dan ke kanan, dapat memperberat atau memperingan nyeri yang Anda rasakan?',

    'questions.neuropathic.7.title': 'Nyeri yang dirasakan berhubungan dengan gejala distesia (seperti: gatal atau terasa seperti ada yang merayap)',
    'questions.neuropathic.7.subtitle': 'Apakah nyeri yang Anda rasakan terasa gatal atau seperti ada yang merayap?',

    'questions.neuropathic.8.title': 'Nyeri yang dirasakan terjadi secara spontan dan memberat',
    'questions.neuropathic.8.subtitle':
        'Apakah nyeri Anda terasa lebih berat bila Anda sedang sedih, marah, stres, atau sedang bermasalah dengan orang lain?',

    // Physical examination
    'questions.neuropathic.9.title':
        'Nyeri memberat dengan tes pergerakan, diantaranya pergerakan aktif/pasif, Neurodinamik dengan tes SLR dan tes Plexus Brachialis',
    'questions.neuropathic.9.subtitle': '',

    'questions.neuropathic.10.title': 'Nyeri timbul dengan palpasi pada jaringan saraf yang cedera',
    'questions.neuropathic.10.subtitle': '',

    'questions.neuropathic.11.title':
        'Pemeriksaan neurologis didapatkan gangguan reflex, sensasi dan kekuatan otot menurun yang terdistribusi secara dermatom',
    'questions.neuropathic.11.subtitle': '',

    'questions.neuropathic.12.title': 'Ditemukannya gerakan antalgik',
    'questions.neuropathic.12.subtitle': '',

    'questions.neuropathic.13.title': 'Ditemukannya hiperalgesia atau alodinia',
    'questions.neuropathic.13.subtitle': '',

    // Central Sensitization Pain Questions
    'questions.central.1.title': 'Ketidaksesuaian antara nyeri yang dirasakan dengan aktivitas yang dilakukan',
    'questions.central.1.subtitle': 'Apakah Anda merasakan nyeri bila melakukan gerakan-gerakan ringan?',

    'questions.central.2.title': 'Nyeri yang dirasakan tidak dipengaruhi oleh faktor mekanis (beban)',
    'questions.central.2.subtitle': 'Apakah Anda merasakan nyeri tidak sedang melakukan suatu gerakan?',

    'questions.central.3.title': 'Nyeri yang terjadi tidak dapat diprediksikan polanya terhadap provokasi yang dilakukan',
    'questions.central.3.subtitle': 'Apakah Anda bisa merasakan nyeri yang timbul kapan saja?',

    'questions.central.4.title': 'Nyeri yang dirasakan menetap melebihi waktu penyembuhan jaringan',
    'questions.central.4.subtitle': 'Apakah nyeri tetap dirasakan walaupun luka yang Anda alami sudah sembuh?',

    'questions.central.5.title': 'Nyeri yang dirasakan disproporsional terhadap sifat atau patologi cedera',
    'questions.central.5.subtitle': 'Apakah Anda merasakan nyeri yang berat pada kondisi luka atau cedera yang ringan?',

    'questions.central.6.title': 'Nyeri yang dirasakan terdistribusi secara luas dan tidak sesuai anatomis',
    'questions.central.6.subtitle': 'Apakah Anda merasakan nyeri di banyak atau hampir seluruh bagian tubuh?',

    'questions.central.7.title':
        'Nyeri berhubungan dengan gangguan psikososial (seperti: emosi negatif, kurang percaya diri, masalah dalam hubungan keluarga/pekerjaan/lingkungan)',
    'questions.central.7.subtitle':
        'Apakah nyeri Anda terasa lebih berat bila Anda sedang sedih, marah, stres, atau sedang bermasalah dengan orang lain?',

    'questions.central.8.title':
        'Pemberian analgesik/NSAID tidak menghasilkan respon yang diharapkan dan atau pemberian anti epileptik (seperti Gabapenin, Pregabalin)/anti-depresan (seperti Amitriptilin) lebih baik dalam mengurangi nyeri',
    'questions.central.8.subtitle': '',

    'questions.central.9.title': 'Nyeri yang dirasakan berhubungan dengan disabilitas fungsional',
    'questions.central.9.subtitle': 'Apakah nyeri menyebabkan terganggunya semua kegiatan Anda?',

    'questions.central.10.title': 'Nyeri timbul pada malam hari yang menyebabkan gangguan tidur',
    'questions.central.10.subtitle': 'Apakah nyeri mengganggu tidur Anda?',

    'questions.central.11.title': 'Nyeri yang dirasakan berhubungan dengan gejala distesia (seperti: dingin, menjalar atau seperti ada yang merayap)',
    'questions.central.11.subtitle': 'Apakah nyeri Anda terasa seperti dingin, menjalar, atau seperti ada yang merayap?',

    'questions.central.12.title': 'Apabila nyeri terstimulasi, maka dibutuhkan waktu yang lama untuk nyeri tersebut menghilang',
    'questions.central.12.subtitle': 'Apakah nyeri Anda mudah terjadi, dan butuh waktu yang lama sebelum menghilang?',

    // Physical examination
    'questions.central.13.title': 'Uji gerak dapat menyebabkan nyeri yang tidak proporsional',
    'questions.central.13.subtitle': '',

    'questions.central.14.title': 'Uji gerak dapat menyebabkan nyeri yang tidak konsisten',
    'questions.central.14.subtitle': '',

    'questions.central.15.title': 'Uji gerak dapat menyebabkan nyeri yang non mekanik atau non anatomis',
    'questions.central.15.subtitle': '',

    'questions.central.16.title': 'HIperalgesia (primer, sekunder)',
    'questions.central.16.subtitle': '',

    'questions.central.17.title': 'Alodinia',
    'questions.central.17.subtitle': '',

    'questions.central.18.title': 'HIperpatia',
    'questions.central.18.subtitle': '',
  },
};
