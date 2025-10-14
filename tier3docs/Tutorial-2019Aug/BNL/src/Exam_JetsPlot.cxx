// stdlib functionality
#include <iostream>
#include <stdlib.h>
// ROOT functionality
#include <TFile.h>
#include <TH1D.h>
// ATLAS EDM functionality
#include "xAODRootAccess/Init.h"
#include "xAODRootAccess/TEvent.h"
#include "xAODEventInfo/EventInfo.h"
#include "xAODJet/JetContainer.h"

static void show_usage(std::string name)
{
    std::cerr << "Usage: " << name << " <option(s)> inputRootFile\n"
              << "\n\tA simple example to make a few jet plots\n\n"
              << "Options:\n"
              << "\t-h,--help\t\tShow this help message\n"
              << std::endl;
}

int main(int argc, char **argv) {

  if (argc < 2) {
     std::cout << "Please specify one argument as the input file" << std::endl;
     exit (EXIT_FAILURE);
  }

  std::string arg;
  for (int i = 1; i < argc; ++i) {
      arg = argv[i];
      if ((arg == "-h") || (arg == "--help")) {
         show_usage(argv[0]);
         return 0;
      }
  }

  TString inputFilePath = arg;

  // initialize the xAOD EDM
  xAOD::Init();

  // open the input file
  // TString inputFilePath = "/home/atlas/Bootcamp/Data/mc16_13TeV.345055.PowhegPythia8EvtGen_NNPDF3_AZNLO_ZH125J_MINLO_llbb_VpT.deriv.DAOD_EXOT27.e5706_s3126_r10724_p3840/DAOD_EXOT27.17882744._000026.pool.root.1";
  xAOD::TEvent event;
  std::unique_ptr< TFile > iFile ( TFile::Open(inputFilePath, "READ") );
  event.readFrom( iFile.get() );

  // make histograms for storage
  TH1D *h_njets_raw = new TH1D("h_njets_raw","",20,0,20);

  TH1D *h_mjj_raw = new TH1D("h_mjj_raw","",100,0,500);

  // for counting events
  unsigned count = 0;

  // get the number of events in the file to loop over
  const Long64_t numEntries = event.getEntries();

  std::cout << "This file " << basename(inputFilePath.Data()) << " contains " << numEntries << " events" << std::endl;

  int nevts_everyPrint = 100; // print for every number of events

  // primary event loop
  for ( Long64_t i=0; i<numEntries; ++i ) {

    // Load the event
    event.getEntry( i );

    // Load xAOD::EventInfo and print the event info
    const xAOD::EventInfo * ei = nullptr;
    if (i%nevts_everyPrint == 0) {
       event.retrieve( ei, "EventInfo" );
       std::cout << "Processing iEvt=" << i+1 << ", run # " << ei->runNumber() << ", event # " << ei->eventNumber() << std::endl;
    }

    // retrieve the jet container from the event store
    const xAOD::JetContainer* jets = nullptr;
    event.retrieve(jets, "AntiKt4EMTopoJets");

    // make temporary vector of jets for those which pass selection
    std::vector<xAOD::Jet> jets_raw;

    // loop through all of the jets and make selections with the helper
    for(const xAOD::Jet* jet : *jets) {
      // print the kinematics of each jet in the event
      if (i%nevts_everyPrint == 0) {
         std::cout << "Jet : " << jet->pt() << jet->eta() << jet->phi() << jet->m() << std::endl;
      }

      jets_raw.push_back(*jet);

    }

    // fill the analysis histograms accordingly
    h_njets_raw->Fill( jets_raw.size() );

    if( jets_raw.size()>=2 ){
      h_mjj_raw->Fill( (jets_raw.at(0).p4()+jets_raw.at(1).p4()).M()/1000. );
    }

    // counter for the number of events analyzed thus far
    count += 1;
  }

  // open TFile to store the analysis histogram output
  TFile *fout = new TFile("myOutputFile.root","RECREATE");

  h_njets_raw->Write();

  h_mjj_raw->Write();

  fout->Close();

  // exit from the main function cleanly
  return 0;
}
