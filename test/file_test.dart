library file_test;

import 'test_common.dart';
import 'package:tekartik_midi/midi.dart';

main() {
  group('midi file', () {
    test('time divisions ppq', () {
      MidiFile file = new MidiFile();
      file.timeDivision = 3;

      expect(file.ppq, file.timeDivision);

      file.ppq = 4;
      expect(file.ppq, file.timeDivision);

      expect(file.divisionCountPerFrame, isNull);
      expect(file.frameCountPerSecond, isNull);
    });

    test('time divisions frame', () {
      MidiFile file = new MidiFile();
      file.timeDivision = 59176;

      expect(file.ppq, null);
      expect(file.frameCountPerSecond, 25);
      expect(file.divisionCountPerFrame, 40);

      file.setFrameDivision(29, 41);
      expect(file.ppq, null);
      expect(file.frameCountPerSecond, 29.97);
      expect(file.divisionCountPerFrame, 41);
    });

    test('file equals', () {
      MidiFile file = new MidiFile();
      expect(file, file);

      MidiFile file2 = new MidiFile();
      expect(file, file2);

      file2.timeDivision = 1;
      expect(file, isNot(file2));
      file.timeDivision = 1;
      file.fileFormat = 1;
      file2.fileFormat = 0;
      expect(file, isNot(file2));
      file.fileFormat = 0;
      expect(file, file2);

      MidiTrack track = new MidiTrack();
      file.addTrack(track);

      expect(file, isNot(file2));
      MidiTrack track2 = new MidiTrack();
      expect(track, track2);
//
//      track.events.add(new TempoEvent(0, 120));
//      expect(track, isNot(track2));
//      track2.events.add(new TempoEvent(0, 120));
//      expect(track, track2);
    });
  });
}