CREATE TABLE IF NOT EXISTS answers (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS blocks (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    answer_id INT NOT NULL,
    CONSTRAINT fk_answer_id
      FOREIGN KEY(answer_id) 
	  REFERENCES answers(id)
);

CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    body TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS state (
    id TEXT PRIMARY KEY,
    value TEXT NOT NULL
);


INSERT INTO answers(id, title)
VALUES(1, 'These are the voyages'),
	(2, 'Data on friendship'),
	(3, 'Star Trek API'),
	(4, 'Maybe Riker'),
	(5, 'Maybe Data with Beard'),
	(6, 'Borg Hails'),
	(7, 'Data or Spock?'),
	(8, 'Not Picard! Not anyone, in fact');

INSERT INTO blocks(id, content, answer_id)
VALUES(1, '[{"type": "text", "body": "These are the voyages of the Starship Enterprise"}, {"type": "text", "body": " Its continuing mission, to explore strange new worlds"}, {"type": "text", "body": " To seek out new life and new civilizations"}, {"type": "text", "body": " To boldly go where no one has gone before"}, {"type": "text", "body": ""}]', 1),
	(2, '[{"type": "text", "body": "I never knew what a friend was until I met Geordi"}, {"type": "text", "body": " He spoke to me as though I were human"}, {"type": "text", "body": " He treated me no differently from anyone else"}, {"type": "text", "body": " He accepted me for what I am"}, {"type": "text", "body": " And that, I have learned, is friendship"}, {"type": "text", "body": ""}, {"type": "image", "url": "http://vignette.wikia.nocookie.net/memoryalpha/images/4/4f/Data%2C_2366.jpg/revision/latest?cb=20130529102644&path-prefix=en"}]', 2),
	(3, '[{"type": "text", "body": "Api call time!"}, {"type": "http", "success": [{"type": "text", "body": "Made it so!"}, {"type": "image", "url": "https://treknews.net/wp-content/uploads/2011/05/2.jpg", "alt-text": "picard thumbs up"}], "failure": [{"type": "random", "body": [{"type": "image", "url": "https://d13ezvd6yrslxm.cloudfront.net/wp/wp-content/images/startrek-picard-facepalm-700x341.jpg", "alt-text": "picard facepalm"}, {"type": "image", "url": "https://www.everseradio.com/wp-content/uploads/2009/06/facepalm.png", "alt-text": "picard double facepalm"}]}]}]', 3),
	(4, '[{"type": "maybe", "chance": 0.5, "body": [{"type": "image", "url": "https://ca.startrek.com/sites/default/files/styles/content_full/public/images/2019-07/18ead4c77c3f40dabf9735432ac9d97a.jpg", "alt-text": "Riker with beard"}]}]', 4),
	(5, '[{"type": "text", "body": "Forbidden knowledge!"}, {"type": "maybe", "chance": 0.3, "body": [{"type": "image", "url": "https://vignette.wikia.nocookie.net/memoryalpha/images/7/7e/Data_wearing_a_beard.jpg/revision/latest?cb=20121212024612&path-prefix=en"}]}]', 5),
	(6, '[{"type": "random", "body": [{"type": "text", "body": "You will be assimilated. Resistance is futile."}, {"type": "text", "body": "We are the Borg. Lower your shields and surrender your ships. We will add your biological and technological distinctiveness to our own. Your culture will adapt to service us. Resistance is futile."}, {"type": "text", "body": "We are the Borg. Your biological and technological distinctiveness will be added to our own. Resistance is futile."}]}, {"type": "random", "body": [{"type": "image", "url": "https://vignette.wikia.nocookie.net/memoryalpha/images/4/48/Picard_dreams_his_assimilation.jpg/revision/latest?cb=20120317185405&path-prefix=en"}, {"type": "image", "url": "https://vignette.wikia.nocookie.net/memoryalpha/images/4/40/Hugh-Drone.jpg/revision/latest?cb=20141207193522&path-prefix=en", "alt-text": "Hugh"}]}]', 6),
	(7, '[{"type": "text", "body": "Data or Spock?"}, {"type": "text", "body": "<drum roll>"}, {"type": "http", "success": [{"type": "image", "url": "https://cdn1.thr.com/sites/default/files/imagecache/768x433/2018/02/star_trek_tv_spock_3_copy_-_h_2018.jpg", "alt-text": "Spock!"}], "failure": [{"type": "image", "url": "https://i.stack.imgur.com/JwRfI.png"}, {"type": "wait", "wait-time": 42}]}]', 7),
	(8, '[]', 8);

INSERT INTO messages(id, body)
VALUES(1, 'With the {74c695031a554c2ebfdb2ee123c8b4f6|something} link, the chain is forged. The {74c695031a554c2ebfdb2ee123c8b4f6|} speech censured, the {74c695031a554c2ebfdb2ee123c8b4f6|} thought forbidden, the {74c695031a554c2ebfdb2ee123c8b4f6|} freedom denied - chains us all irrevocably. '),
	(2, 'Life''s true gift is the capacity to enjoy {6b0f3753e17d42598a6b2b8468e3c20f|SOMETHING}.'),
	(3, 'Commander William T. {4b0f3753e17d42598a6b2b8468e3b19e|}: It''s just that our mental pathways have become accustomed to your sensory input patterns. Lt. Commander Data: Hm. I understand. I am also fond of you, Commander. And you as well, Counselor.'),
	(4, 'It''s elementary, my dear {4b0f3753e17d42598a6b2b8468e3b19e|Watson}. Sir.'),
	(5, 'Space... The final frontier. These are the voyages of the starship {f88845ecb8794308af2ecbb663ecf667|}. It''s continuing mission, to explore strange new worlds. To seek out new life and new civilizations. To boldly go where no one has gone before.'),
	(6, '{b8db1b3a29454bafbed460306e7f8318|some guy} and {9926d7be6bb44850bf34d1f7cc3c2018|another guy} at Tenagra!'),
	(7, 'Let''s make sure that history never forgets the name... {f88845ecb8794308af2ecbb663ecf667|}');

INSERT INTO state(id, value)
VALUES('74c695031a554c2ebfdb2ee123c8b4f6', 'first'),
	('4b0f3753e17d42598a6b2b8468e3b19e', 'Riker'),
	('f88845ecb8794308af2ecbb663ecf667', 'Enterprise'),
	('b8db1b3a29454bafbed460306e7f8318', 'Darmok'),
	('c9fdac3a29454bafbed460306e7f1111', 'Red Herring'),
	('9926d7be6bb44850bf34d1f7cc3c2018', 'Jalad');
