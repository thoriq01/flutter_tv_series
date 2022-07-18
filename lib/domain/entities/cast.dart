import 'package:equatable/equatable.dart';

class MovieCastEntities extends Equatable {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartement;
  final String name;
  final String originalName;
  final double poularity;
  final String profilePath;

  MovieCastEntities(this.adult, this.gender, this.id, this.knownForDepartement, this.name, this.originalName, this.poularity, this.profilePath);

  @override
  List<Object?> get props => [
        adult,
        gender,
        id,
        knownForDepartement,
        name,
        originalName,
        poularity,
        profilePath,
      ];
}
