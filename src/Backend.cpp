#include "Backend.h"
#include <qvariant.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <qdebug.h>
#define byte win_byte_override
#include <windows.h>
#undef byte

#include <sstream>

Backend::Backend()
{
	m_field = QList<QList<int>>(4, QList<int>(4, 0));

	HANDLE file = CreateFileW(
		L"settings.txt",
		GENERIC_READ,
		FILE_SHARE_READ,
		NULL,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		NULL
	);
	if (file != INVALID_HANDLE_VALUE) {
		DWORD fileSize = GetFileSize(file, NULL);

		string buff;
		buff.resize(fileSize);

		DWORD bytesRead;
		ReadFile(file, buff.data(), fileSize, &bytesRead, NULL);


		int i = 0;
		int j = 0;


		std::stringstream ss(buff);
		QList<int> temp;

		int value;
		while (ss >> value) {
			temp.push_back(value);
		}
		m_field = { {temp[0],temp[1],temp[2],temp[3]},
		{temp[4],temp[5],temp[6],temp[7]},
		{temp[8],temp[9],temp[10],temp[11]},
		{temp[12],temp[13],temp[14],temp[15]}
		};

		if (temp.size() >= 17)
			score = temp[16];
		if (temp.size() >= 18)
			best_score = temp[17];
		if (temp.size() >= 19)
			game_mode = temp[18];
		if (temp.size() >= 20)
			current_sound = temp[19];
		if (temp.size() >= 21)
			theme = temp[20];
	}
	else {
		theme = 0;
		game_mode = 1;
		score = 0;
		best_score = 0;
		current_sound = 0;
		m_field = {
			{0,0,0,0},
			{0,0,2,0},
			{0,0,2,0},
			{0,0,0,0}
		};
	}
	CloseHandle(file);

}

void Backend::setRoot(QObject* root)
{
	m_root = root;
	score_text = m_root->findChild<QObject*>("score_text");
	button_new_game_mousearea = m_root->findChild<QObject*>("button_new_game_mousearea");
	settings_button_mousearea = m_root->findChild<QObject*>("settings_button_mousearea");
	best_score_text = m_root->findChild<QObject*>("best_score_text");
	best_score_text->setProperty("text", QString::number(best_score));
	rules_menu_button = m_root->findChild<QObject*>("rules_menu_button");
	sounds_menu_button = m_root->findChild<QObject*>("sounds_menu_button");

	switch (current_sound)
	{
	case 0:
		sounds_menu_button->setProperty("text", "No sound");
		break;
	case 1:
		sounds_menu_button->setProperty("text", "1");
		break;
	case 2:
		sounds_menu_button->setProperty("text", "2");
		break;
	case 3:
		sounds_menu_button->setProperty("text", "3");
		break;
	case 4:
		sounds_menu_button->setProperty("text", "4");
		break;
	}
	QMetaObject::invokeMethod(m_root, "set_sound",
		Q_ARG(QVariant, QString::number(current_sound)));

	if (game_mode == 0) {
		QMetaObject::invokeMethod(m_root, "set_rules_menu_button_text", Q_ARG(QVariant, QString("Classic")));
		QObject* custom_rules_text = m_root->findChild<QObject*>("custom_rules_text");
		custom_rules_text->setProperty("visible", false);
		QObject* classic_rules_text = m_root->findChild<QObject*>("classic_rules_text");
		classic_rules_text->setProperty("visible", true);
	}
	else {
		QMetaObject::invokeMethod(m_root, "set_rules_menu_button_text", Q_ARG(QVariant, QString("Custom")));
		QObject* custom_rules_text = m_root->findChild<QObject*>("custom_rules_text");
		custom_rules_text->setProperty("visible", true);
		QObject* classic_rules_text = m_root->findChild<QObject*>("classic_rules_text");
		classic_rules_text->setProperty("visible", false);
	}

	if (theme == 0) {
		QMetaObject::invokeMethod(m_root, "set_normal_theme");
		QMetaObject::invokeMethod(m_root, "set_theme_menu_button_text", Q_ARG(QVariant, "Normal"));

	}
	else if (theme == 1) {
		QMetaObject::invokeMethod(m_root, "set_dark_theme");
		QMetaObject::invokeMethod(m_root, "set_theme_menu_button_text", Q_ARG(QVariant, "Dark"));
	}
	else if (theme == 2) {
		QMetaObject::invokeMethod(m_root, "set_neon_theme");
		QMetaObject::invokeMethod(m_root, "set_theme_menu_button_text", Q_ARG(QVariant, "Neon"));
	}


}

void Backend::left_pressed()
{


	if (game_mode == 1) {
		for (int i = m_field.size() - 1; i >= 0; i--) {
			for (int j = m_field[i].size() - 1; j >= 0; j--) {
				if (m_field[i][j] != 0) {
					int temp_j = j - 1;
					int num = m_field[i][j];


					//// move to the left
					if (temp_j >= 0 and m_field[i][temp_j] == 0) {
						while (temp_j >= 0 and m_field[i][temp_j] == 0) {

							if (m_field[i][temp_j] == 0) {
								m_field[i][temp_j] = num;
								m_field[i][j] = 0;
								m_field[i][temp_j + 1] = 0;
							}
							temp_j--;
						}
					}

					temp_j = 1;
					while (temp_j < 4) {
						if (m_field[i][temp_j - 1] == 0) {
							m_field[i][temp_j - 1] = m_field[i][temp_j];
							m_field[i][temp_j] = 0;
						}

						temp_j += 1;

					}

					temp_j = j - 1;
					if (temp_j >= 0 and m_field[i][temp_j] != m_field[i][j] and m_field[i][temp_j] != 0) continue;


					/// if there are 4 same numbers in 1 row
					if (j == 3 and m_field[i][j] == m_field[i][j - 1] and m_field[i][j] == m_field[i][j - 2] and m_field[i][j] == m_field[i][j - 3]) {
						m_field[i][j - 3] = m_field[i][j] * 4;
						m_field[i][j] = 0;
						m_field[i][j - 1] = 0;
						m_field[i][j - 2] = 0;
						score += m_field[i][j - 3];
					}/////////////
					else {
						while (temp_j >= 0) {
							if (m_field[i][j] == m_field[i][temp_j]) {
								m_field[i][temp_j] = m_field[i][j] * 2;
								score += m_field[i][temp_j];
								m_field[i][j] = 0;

							}

							temp_j -= 1;

						}

						//// double check
						temp_j = 1;
						while (temp_j < 4) {
							if (m_field[i][temp_j - 1] == 0) {
								m_field[i][temp_j - 1] = m_field[i][temp_j];
								m_field[i][temp_j] = 0;
							}

							temp_j += 1;

						}
					}
				}
			}


			//// special case e.g -> 4 2 2 0
			//// 4 2 2 0   ->  4 4   -> 8
			//// or 2 4 2 2  -> 2 0 4 4 -> 0 0 2 8
			for (int j = m_field[i].size() - 1; j >= 0; j--) {
				if (m_field[i][j] != 0) {

					int temp_j = j - 1;
					while (temp_j >= 0) {
						if (m_field[i][temp_j] != 0 and m_field[i][temp_j] != m_field[i][j]) break;
						if (m_field[i][j] == m_field[i][temp_j]) {
							m_field[i][temp_j] = m_field[i][temp_j] * 2;
							score += m_field[i][temp_j];
							m_field[i][j] = 0;
						}

						temp_j -= 1;

					}
					temp_j = 1;
					while (temp_j < 4) {
						if (m_field[i][temp_j - 1] == 0) {
							m_field[i][temp_j - 1] = m_field[i][temp_j];
							m_field[i][temp_j] = 0;
						}

						temp_j += 1;

					}


				}
			}
			//// special case -> 8 4 2 2 -> 8 8 0 0 -> 16 0 0 0 
			if (m_field[i][0] == m_field[i][1]) {
				m_field[i][0] = m_field[i][0] * 2;
				score += m_field[i][0];
				m_field[i][1] = 0;
			}
		}
	}







	else { /////////////// CLASSIC MODE
		///// move
		can_spawn_two = false;
		for (int i = 0; i < m_field.size(); i++) {
			for (int j = 0; j < m_field[i].size(); j++) {
				if (m_field[i][j] != 0 and j != 0) {
					int temp_j = j - 1;
					int num = m_field[i][j];

					//// move to the left
					if (temp_j >= 0 and m_field[i][temp_j] == 0) {
						while (temp_j >= 0 and m_field[i][temp_j] == 0) {

							m_field[i][temp_j] = num;
							m_field[i][j] = 0;
							m_field[i][temp_j + 1] = 0;
							can_spawn_two = true;
							temp_j--;
						}
					}
				}
			}
		}

		//// add
		for (int i = 0; i < m_field.size(); i++) {
			for (int j = 0; j < m_field[i].size(); j++) {
				if (m_field[i][j] != 0) {
					int temp_j = j - 1;
					int num = m_field[i][j];
					if (temp_j >= 0 and m_field[i][temp_j] == m_field[i][j] and m_field[i][temp_j] != 0) {
						m_field[i][temp_j] = num * 2;
						m_field[i][j] = 0;
						can_spawn_two = true;
						score += num * 2;
					}
				}
			}
		}

		//// one more move
		for (int i = 0; i < m_field.size(); i++) {
			for (int j = 0; j < m_field[i].size(); j++) {
				if (m_field[i][j] != 0 and j != 0) {
					int temp_j = j - 1;
					int num = m_field[i][j];

					//// move to the left
					if (temp_j >= 0 and m_field[i][temp_j] == 0) {
						while (temp_j >= 0 and m_field[i][temp_j] == 0) {

							m_field[i][temp_j] = num;
							m_field[i][j] = 0;
							m_field[i][temp_j + 1] = 0;
							can_spawn_two = true;
							temp_j--;
						}
					}
				}
			}
		}
	}


	generate_two();
	//check_loose();
	emit fieldChanged();
}

void Backend::right_pressed()
{

	if (game_mode == 1) {
		for (int i = 0; i < m_field.size(); i++) {
			for (int j = 0; j < m_field[i].size(); j++) {
				if (m_field[i][j] != 0) {
					int temp_j = j + 1;
					int num = m_field[i][j];
					if (temp_j == 4) {
						continue;
					}

					/// move to the right
					if (temp_j < 4 and m_field[i][temp_j] == 0) {
						while (temp_j < 4 and m_field[i][temp_j] == 0) {

							if (m_field[i][temp_j] == 0) {
								m_field[i][temp_j] = num;
								m_field[i][j] = 0;
								m_field[i][temp_j - 1] = 0;
							}
							temp_j++;
						}
					}

					temp_j = j + 1;
					//// if 4 same nums in one row
					if (j == 0 and m_field[i][j] == m_field[i][j + 1] and m_field[i][j] == m_field[i][j + 2] and m_field[i][j] == m_field[i][j + 3]) {
						m_field[i][j + 3] = m_field[i][j] * 4;
						m_field[i][j] = 0;
						m_field[i][j + 1] = 0;
						m_field[i][j + 2] = 0;

						score += m_field[i][j + 3];
						//added_coords << QVariantMap{ {"r", j+3}, {"c", i} };
					}//////////////

					else {

						temp_j = j + 1;
						while (temp_j < 4) {
							if (m_field[i][temp_j] != 0 and m_field[i][temp_j] != m_field[i][j]) break;
							if (m_field[i][j] == m_field[i][temp_j]) {
								m_field[i][temp_j] = m_field[i][temp_j] * 2;
								m_field[i][j] = 0;

								score += m_field[i][temp_j];
								//added_coords << QVariantMap{ {"r", temp_j}, {"c", i} };
							}

							temp_j += 1;

						}

						//// final movement
						temp_j = 2;
						while (temp_j >= 0) {
							if (m_field[i][temp_j + 1] == 0) {
								m_field[i][temp_j + 1] = m_field[i][temp_j];
								m_field[i][temp_j] = 0;
							}

							temp_j -= 1;

						}  ///

					}




				}
			}






			//// special case e.g -> 4 2 2 0
			//// 4 2 2 0   ->  4 4   -> 8
			//// or 2 4 2 2  -> 2 0 4 4 -> 0 0 2 8
			for (int j = 0; j < m_field[i].size(); j++) {
				if (m_field[i][j] != 0) {

					int temp_j = j + 1;
					while (temp_j < 4) {
						if (m_field[i][temp_j] != 0 and m_field[i][temp_j] != m_field[i][j]) break;
						if (m_field[i][j] == m_field[i][temp_j]) {
							m_field[i][temp_j] = m_field[i][temp_j] * 2;
							m_field[i][j] = 0;

							score += m_field[i][temp_j];
							//added_coords << QVariantMap{ {"r", temp_j}, {"c", i} };
						}

						temp_j += 1;

					}
					temp_j = 2;
					while (temp_j >= 0) {
						if (m_field[i][temp_j + 1] == 0) {
							m_field[i][temp_j + 1] = m_field[i][temp_j];
							m_field[i][temp_j] = 0;
						}

						temp_j -= 1;

					}


				}
			}

			//// special case -> 2 2 4 8 -> 0 0 8 8 -> 0 0 0 16
			if (m_field[i][2] == m_field[i][3]) {
				m_field[i][3] = m_field[i][3] * 2;
				m_field[i][2] = 0;

				score += m_field[i][3];

				//added_coords << QVariantMap{ {"r", 3}, {"c", 1} };
				//added_coords << QVariantMap{ {"r", 2}, {"c", 0} };
			}
		}
	}





	else { /////////////// CLASSIC MODE
		can_spawn_two = false;
		for (int i = m_field.size() - 1; i >= 0; i--) {
			for (int j = m_field.size() - 1; j >= 0; j--) {
				if (m_field[i][j] != 0 and j != 3) {
					int temp_j = j + 1;
					int num = m_field[i][j];

					//// move to the right
					if (temp_j < 4 and m_field[i][temp_j] == 0) {
						while (temp_j < 4 and m_field[i][temp_j] == 0) {

							m_field[i][temp_j] = num;
							m_field[i][j] = 0;
							m_field[i][temp_j - 1] = 0;
							can_spawn_two = true;
							temp_j++;
						}
					}
				}
			}
		}


		for (int i = m_field.size() - 1; i >= 0; i--) {
			for (int j = m_field.size() - 1; j >= 0; j--) {
				if (m_field[i][j] != 0) {
					int temp_j = j + 1;
					int num = m_field[i][j];
					if (temp_j < 4 and m_field[i][temp_j] == m_field[i][j] and m_field[i][temp_j] != 0) {
						m_field[i][temp_j] = num * 2;
						m_field[i][j] = 0;
						score += num * 2;
						can_spawn_two = true;
					}
					//// move to the right

				}
			}
		}


		for (int i = m_field.size() - 1; i >= 0; i--) {
			for (int j = m_field.size() - 1; j >= 0; j--) {
				if (m_field[i][j] != 0 and j != 3) {
					int temp_j = j + 1;
					int num = m_field[i][j];

					//// move to the right
					if (temp_j < 4 and m_field[i][temp_j] == 0) {
						while (temp_j < 4 and m_field[i][temp_j] == 0) {

							m_field[i][temp_j] = num;
							m_field[i][j] = 0;
							m_field[i][temp_j - 1] = 0;
							can_spawn_two = true;
							temp_j++;
						}
					}
				}
			}
		}
	}



	generate_two();
	//check_loose();
	emit fieldChanged();
}

void Backend::up_pressed()
{
	if (game_mode == 1) {
		for (int i = m_field.size() - 1; i >= 0; i--) {
			for (int j = m_field[i].size() - 1; j >= 0; j--) {
				if (m_field[i][j] != 0) {
					int temp_i = i - 1;
					int num = m_field[i][j];

					if (temp_i >= 0 and m_field[temp_i][j] == 0) {
						while (temp_i >= 0 and m_field[temp_i][j] == 0) {

							if (m_field[temp_i][j] == 0) {
								m_field[temp_i][j] = num;
								m_field[i][j] = 0;
								m_field[temp_i + 1][j] = 0;
							}
							temp_i--;
						}
					}




					temp_i = i - 1;
					if (temp_i >= 0 and m_field[temp_i][j] != m_field[i][j] and m_field[temp_i][j] != 0) continue;

					if (i == 3 and m_field[i][j] == m_field[i - 1][j] and m_field[i][j] == m_field[i - 2][j] and m_field[i][j] == m_field[i - 3][j]) {
						m_field[i - 3][j] = m_field[i][j] * 4;
						m_field[i][j] = 0;
						m_field[i - 1][j] = 0;
						m_field[i - 2][j] = 0;
						score += m_field[i - 3][j];
					}
					else {
						while (temp_i >= 0) {

							if (m_field[i][j] == m_field[temp_i][j]) {
								m_field[temp_i][j] = m_field[temp_i][j] * 2;
								m_field[i][j] = 0;
								score += m_field[temp_i][j];
							}

							temp_i -= 1;

						}
						//// final movement
						temp_i = 3;
						while (temp_i > 0) {
							if (m_field[temp_i - 1][j] == 0) {
								m_field[temp_i - 1][j] = m_field[temp_i][j];
								m_field[temp_i][j] = 0;
							}

							temp_i -= 1;

						}  ///
					}

				}
			}


		}


		//// special case e.g -> 4 2 2 0
			//// 4 2 2 0   ->  4 4   -> 8
			//// or 2 4 2 2  -> 2 0 4 4 -> 0 0 2 8


		for (int j = 0; j < m_field[0].size(); j++) {
			for (int i = 0; i < m_field.size(); i++) {
				if (m_field[i][j] != 0) {

					int temp_i = i + 1;
					while (temp_i < 4) {
						if (m_field[temp_i][j] != 0 and m_field[temp_i][j] != m_field[i][j]) break;
						if (m_field[i][j] == m_field[temp_i][j]) {
							m_field[i][j] = m_field[i][j] * 2;
							m_field[temp_i][j] = 0;
							score += m_field[i][j];
						}

						temp_i += 1;

					}
					temp_i = 2;
					while (temp_i > 0) {
						if (m_field[temp_i - 1][j] == 0) {
							m_field[temp_i - 1][j] = m_field[temp_i][j];
							m_field[temp_i - 1][j] = 0;
						}

						temp_i -= 1;

					}


				}
			}
		}
	}
	else { /////////////// CLASSIC MODE
		can_spawn_two = false;
		for (int j = 0; j < m_field[0].size(); j++) {
			for (int i = 0; i < m_field.size(); i++) {
				if (m_field[i][j] != 0) {

					int temp_i = i - 1;
					int num = m_field[i][j];

					while (temp_i >= 0 and m_field[temp_i][j] == 0) {

						m_field[temp_i][j] = num;
						m_field[i][j] = 0;
						m_field[temp_i + 1][j] = 0;
						can_spawn_two = true;
						temp_i--;
					}

				}
			}
		}


		for (int j = 0; j < m_field[0].size(); j++) {
			for (int i = 0; i < m_field.size(); i++) {
				if (m_field[i][j] != 0) {
					int temp_i = i - 1;
					int num = m_field[i][j];
					if (temp_i >= 0 and m_field[temp_i][j] == m_field[i][j] and m_field[temp_i][j] != 0) {
						m_field[temp_i][j] = num * 2;
						m_field[i][j] = 0;
						can_spawn_two = true;
						score += num * 2;
					}

				}
			}
		}

		for (int j = 0; j < m_field[0].size(); j++) {
			for (int i = 0; i < m_field.size(); i++) {
				if (m_field[i][j] != 0) {

					int temp_i = i - 1;
					int num = m_field[i][j];

					while (temp_i >= 0 and m_field[temp_i][j] == 0) {

						m_field[temp_i][j] = num;
						m_field[i][j] = 0;
						m_field[temp_i + 1][j] = 0;
						can_spawn_two = true;
						temp_i--;
					}

				}
			}
		}
	}


	generate_two();
	//check_loose();
	emit fieldChanged();
}

void Backend::down_pressed()
{
	if (game_mode == 1) {
		for (int i = 0; i < m_field.size(); i++) {
			for (int j = 0; j < m_field[i].size(); j++) {
				if (m_field[i][j] != 0) {

					int temp_i = i + 1;
					int num = m_field[i][j];

					if (temp_i < 4 and m_field[temp_i][j] == 0) {
						while (temp_i < 4 and m_field[temp_i][j] == 0) {

							if (m_field[temp_i][j] == 0) {
								m_field[temp_i][j] = num;
								m_field[i][j] = 0;
								m_field[temp_i - 1][j] = 0;
							}
							temp_i++;
						}
					}




					temp_i = i + 1;
					if (temp_i < 4 and m_field[temp_i][j] != m_field[i][j] and m_field[temp_i][j] != 0) continue;

					if (i == 0 and m_field[i][j] == m_field[i + 1][j] and m_field[i][j] == m_field[i + 2][j] and m_field[i][j] == m_field[i + 3][j]) {
						m_field[i + 3][j] = m_field[i][j] * 4;
						m_field[i][j] = 0;
						m_field[i + 1][j] = 0;
						m_field[i + 2][j] = 0;
						score += m_field[i + 3][j];
					}
					else {
						while (temp_i < 4) {

							if (m_field[i][j] == m_field[temp_i][j]) {
								m_field[temp_i][j] = m_field[temp_i][j] * 2;
								m_field[i][j] = 0;
								score += m_field[temp_i][j];
							}

							temp_i += 1;

						}
						//// final movement
						temp_i = 0;
						while (temp_i < 3) {
							if (m_field[temp_i + 1][j] == 0) {
								m_field[temp_i + 1][j] = m_field[temp_i][j];
								m_field[temp_i][j] = 0;
							}

							temp_i += 1;

						}  ///
					}

				}
			}


		}


		//// special case e.g -> 4 2 2 0
			//// 4 2 2 0   ->  4 4   -> 8
			//// or 2 4 2 2  -> 2 0 4 4 -> 0 0 2 8


		for (int j = m_field[0].size() - 1; j >= 0; j--) {
			for (int i = m_field.size() - 1; i >= 0; i--) {
				if (m_field[i][j] != 0) {

					int temp_i = i - 1;
					while (temp_i >= 0) {
						if (m_field[temp_i][j] != 0 and m_field[temp_i][j] != m_field[i][j]) break;
						if (m_field[i][j] == m_field[temp_i][j]) {
							m_field[i][j] = m_field[i][j] * 2;
							m_field[temp_i][j] = 0;
							score += m_field[i][j];
						}

						temp_i -= 1;

					}
					temp_i = 3;
					while (temp_i > 0) {
						if (m_field[temp_i - 1][j] == 0) {
							m_field[temp_i - 1][j] = m_field[temp_i][j];
							m_field[temp_i - 1][j] = 0;
						}

						temp_i -= 1;

					}


				}
			}
		}
	}




	else { /////////////// CLASSIC MODE
		can_spawn_two = false;
		for (int j = m_field.size() - 1; j >= 0; j--) {
			for (int i = m_field[j].size() - 1; i >= 0; i--) {
				if (m_field[i][j] != 0) {

					int temp_i = i + 1;
					int num = m_field[i][j];

					while (temp_i < 4 and m_field[temp_i][j] == 0) {

						m_field[temp_i][j] = num;
						m_field[i][j] = 0;
						m_field[temp_i - 1][j] = 0;
						can_spawn_two = true;
						temp_i++;
					}

				}
			}
		}


		for (int j = m_field.size() - 1; j >= 0; j--) {
			for (int i = m_field[j].size() - 1; i >= 0; i--) {
				if (m_field[i][j] != 0) {
					int temp_i = i + 1;
					int num = m_field[i][j];
					if (temp_i < 4 and m_field[temp_i][j] == m_field[i][j] and m_field[temp_i][j] != 0) {
						m_field[temp_i][j] = num * 2;
						m_field[i][j] = 0;
						can_spawn_two = true;
						score += num * 2;
					}

				}
			}
		}

		for (int j = m_field.size() - 1; j >= 0; j--) {
			for (int i = m_field[j].size() - 1; i >= 0; i--) {
				if (m_field[i][j] != 0) {

					int temp_i = i + 1;
					int num = m_field[i][j];

					while (temp_i < 4 and m_field[temp_i][j] == 0) {

						m_field[temp_i][j] = num;
						m_field[i][j] = 0;
						m_field[temp_i - 1][j] = 0;
						can_spawn_two = true;
						temp_i++;
					}

				}
			}
		}
	}

	generate_two();
	emit fieldChanged();
}

Q_INVOKABLE void Backend::set_game_mode(bool mode)
{
	game_mode = mode;
}

void Backend::check_loose()
{
	bool lost = true;
	for (int i = 0; i < m_field.size(); i++) {
		for (int j = 0; j < m_field[i].size(); j++) {
			if (i - 1 >= 0 and m_field[i][j] == m_field[i - 1][j]) {
				lost = false;
				break;
			}
			if (i + 1 < 4 and m_field[i][j] == m_field[i + 1][j]) {
				lost = false;
				break;
			}
			if (j - 1 >= 0 and m_field[i][j] == m_field[i][j - 1]) {
				lost = false;
				break;
			}
			if (j + 1 < 4 and m_field[i][j] == m_field[i][j + 1]) {
				lost = false;
				break;
			}
		}
		if (lost == false) break;
	}

	if (lost == true and free_cells.empty()) {
		QObject* lost_screen = m_root->findChild<QObject*>("lost_screen");
		if (lost_screen != nullptr)
			lost_screen->setProperty("opacity", 1.0);
		QObject* mouse_area = m_root->findChild<QObject*>("mouse_area");
		if (mouse_area != nullptr)
			mouse_area->setProperty("visible", true);

		button_new_game_mousearea->setProperty("enabled", false);
		settings_button_mousearea->setProperty("enabled", false);
		can_spawn_two = true;
	}
}





Q_INVOKABLE void Backend::restart()
{
	m_field = QList<QList<int>>(4, QList<int>(4, 0));
	can_spawn_two = true;
	generate_two();
	generate_two();
	score = 0;
	score_text->setProperty("text", QString::number(score));

}

Q_INVOKABLE void Backend::set_sound(int sound)
{
	current_sound = sound;
}

Q_INVOKABLE void Backend::set_theme(int theme_func)
{
	theme = theme_func;
}

void Backend::generate_two()
{
	srand(time(NULL));
	free_cells.clear();
	for (int i = 0; i < m_field.size(); i++) {
		for (int j = 0; j < m_field[i].size(); j++) {
			if (m_field[i][j] == 0) {
				free_cells.push_back(pair<int, int>(i, j));
			}
		}
	}

	//QVariant safeCopy = added_coords;
	//QMetaObject::invokeMethod(m_root, "set_added_coords", Q_ARG(QVariant, safeCopy));


	if (game_mode == 1) {
		if (!free_cells.empty()) {
			int random_cell = rand() % free_cells.size();
			int i = free_cells[random_cell].first;
			int j = free_cells[random_cell].second;
			m_field[i][j] = 2;

			QObject* board = m_root->findChild<QObject*>("board");
			QMetaObject::invokeMethod(board, "setTilescale",
				Q_ARG(QVariant, i),
				Q_ARG(QVariant, j));

		}
	}
	else if (game_mode == 0) {
		if (can_spawn_two == true) {
			if (!free_cells.empty()) {
				int random_cell = rand() % free_cells.size();
				int i = free_cells[random_cell].first;
				int j = free_cells[random_cell].second;
				srand(time(NULL));
				if (rand() % 10 < 8)
					m_field[i][j] = 2;
				else m_field[i][j] = 4;

				QObject* board = m_root->findChild<QObject*>("board");
				QMetaObject::invokeMethod(board, "setTilescale",
					Q_ARG(QVariant, i),
					Q_ARG(QVariant, j));
			}
		}
	}


	score_text->setProperty("text", QString::number(score));
	if (score > best_score) {
		best_score = score;
		best_score_text->setProperty("text", QString::number(best_score));
	}

	check_loose();
	emit fieldChanged();

}
