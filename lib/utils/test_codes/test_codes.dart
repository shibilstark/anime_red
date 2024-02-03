//  Search > Get Info > Get Servers > StreamLinks code example
// 
// 
// 
// 
// 
              // await getIt<AnimeRepository>()
              //     .searchAnime(query = "naruto", page = 1)
              //     .then((value1) async {
              //   await value1.fold((l) async => log(l.message), (v1r) async {
              //     log("GOT SEARCH RESULTS");

              //     if (v1r.datas.isNotEmpty) {
              //       final infoId = v1r.datas.first.id;
              //       await getIt<AnimeRepository>()
              //           .getAnimeInfo(id: infoId)
              //           .then((value2) {
              //         value2.fold((l) async => log(l.message), (anime) async {
              //           if (anime.episodes.isNotEmpty) {
              //             final episodeId = anime.episodes.first.id;

              //             await getIt<AnimeRepository>()
              //                 .getAvailableServers(episodeId: episodeId)
              //                 .then((value3) {
              //               value3.fold((l) async => log(l.message),
              //                   (servers) async {
              //                 if (servers.isNotEmpty) {
              //                   servers.shuffle();
              //                   await getIt<AnimeRepository>()
              //                       .getStreamingLinks(
              //                           episodeId: episodeId,
              //                           server: servers.first.name)
              //                       .then((value4) {
              //                     value4.fold((l) async => log(l.message),
              //                         (streamingLinksModel) async {
              //                       if (streamingLinksModel
              //                           .sources.isNotEmpty) {
              //                         for (var element
              //                             in streamingLinksModel.sources) {
              //                           log("${element.quality.name} : ${element.url}");
              //                         }
              //                       } else {
              //                         log(" ${anime.title} $episodeId ${servers.first} No Streaming Links Found");
              //                       }
              //                     });
              //                   });
              //                 } else {
              //                   log(" ${anime.title} $episodeId NO Servers Available");
              //                 }
              //               });
              //             });
              //           } else {
              //             log(" ${anime.title}No Episodes Found");
              //           }
              //         });
              //       });
              //     } else {
              //       log("Empty Search Results");
              //     }
              //   });
              // });
            