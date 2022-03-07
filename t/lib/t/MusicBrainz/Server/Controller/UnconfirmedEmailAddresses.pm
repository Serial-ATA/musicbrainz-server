package t::MusicBrainz::Server::Controller::UnconfirmedEmailAddresses;
use Test::Routine;
use Test::Deep qw( cmp_set );

use HTTP::Status qw( :constants );
use Hook::LexWrap;
use Set::Scalar;

with 't::Context', 't::Mechanize';

my @unconfirmed_email_whitelist;

test 'Paths that allow browsing without a confirmed email address' => sub {
    my @actions_without_edit_attribute =
        map {
            my $fqn = $_->fully_qualified_name;
            $fqn =~ s/MusicBrainz::Server:://;
            $fqn;
        }
        grep {
            # Find all actions that users can access. These are actions that
            # are Local, or have a Path/PathPart
            my $attributes = Set::Scalar->new(@{$_->attributes});
            $attributes->size > 0 &&
            (
                (grep /^Path(Part)?/, $attributes->elements) > 0 ||
                $attributes->has('Local')
            ) &&
            !$attributes->has('Edit')
        }
        map { MusicBrainz::Server->controller($_)->get_action_methods }
        grep {
            # Find all concrete MusicBrainz::Server controllers
            my $controller = MusicBrainz::Server->controller($_);
            $controller->isa('Catalyst::Controller') &&
                $controller->meta->name =~ /^MusicBrainz::Server::Controller::/
        } MusicBrainz::Server->controllers;

    cmp_set(
        \@actions_without_edit_attribute,
        \@unconfirmed_email_whitelist
    );
};

@unconfirmed_email_whitelist = (
  'Controller::Account::Subscriptions::Artist::add',
  'Controller::Account::Subscriptions::Artist::remove',
  'Controller::Account::Subscriptions::Collection::add',
  'Controller::Account::Subscriptions::Collection::remove',
  'Controller::Account::Subscriptions::Editor::add',
  'Controller::Account::Subscriptions::Editor::remove',
  'Controller::Account::Subscriptions::Label::add',
  'Controller::Account::Subscriptions::Label::remove',
  'Controller::Account::Subscriptions::Series::add',
  'Controller::Account::Subscriptions::Series::remove',
  'Controller::Account::applications',
  'Controller::Account::change_password',
  'Controller::Account::donation',
  'Controller::Account::edit',
  'Controller::Account::edit_application',
  'Controller::Account::index',
  'Controller::Account::lost_password',
  'Controller::Account::lost_username',
  'Controller::Account::preferences',
  'Controller::Account::register',
  'Controller::Account::register_application',
  'Controller::Account::remove_application',
  'Controller::Account::resend_verification',
  'Controller::Account::reset_password',
  'Controller::Account::revoke_application_access',
  'Controller::Account::verify_email',
  'Controller::Admin::Attributes::attribute_base',
  'Controller::Admin::Attributes::attribute_index',
  'Controller::Admin::Attributes::index',
  'Controller::Admin::StatisticsEvent::create',
  'Controller::Admin::StatisticsEvent::delete',
  'Controller::Admin::StatisticsEvent::edit',
  'Controller::Admin::StatisticsEvent::index',
  'Controller::Admin::WikiDoc::history',
  'Controller::Admin::WikiDoc::index',
  'Controller::Admin::delete_user',
  'Controller::Admin::edit_banner',
  'Controller::Admin::edit_user',
  'Controller::Admin::email_search',
  'Controller::Admin::ip_lookup',
  'Controller::Admin::locked_username_search',
  'Controller::Admin::privilege_search',
  'Controller::Admin::unlock_username',
  'Controller::Ajax::filter_artist_recordings_form',
  'Controller::Ajax::filter_artist_release_groups_form',
  'Controller::Ajax::filter_artist_releases_form',
  'Controller::Area::alias',
  'Controller::Area::aliases',
  'Controller::Area::annotation_diff',
  'Controller::Area::annotation_history',
  'Controller::Area::annotation_revision',
  'Controller::Area::base',
  'Controller::Area::commons_image',
  'Controller::Area::details',
  'Controller::Area::edits',
  'Controller::Area::latest_annotation',
  'Controller::Area::open_edits',
  'Controller::Area::show',
  'Controller::Area::downvote_tags',
  'Controller::Area::upvote_tags',
  'Controller::Area::withdraw_tags',
  'Controller::Area::tags',
  'Controller::Area::wikipedia_extract',
  'Controller::Artist::alias',
  'Controller::Artist::aliases',
  'Controller::Artist::annotation_diff',
  'Controller::Artist::annotation_history',
  'Controller::Artist::annotation_revision',
  'Controller::Artist::base',
  'Controller::Artist::commons_image',
  'Controller::Artist::credit',
  'Controller::Artist::details',
  'Controller::Artist::edits',
  'Controller::Artist::latest_annotation',
  'Controller::Artist::open_edits',
  'Controller::Artist::ratings',
  'Controller::Artist::relationships',
  'Controller::Artist::show',
  'Controller::Artist::downvote_tags',
  'Controller::Artist::upvote_tags',
  'Controller::Artist::withdraw_tags',
  'Controller::Artist::tags',
  'Controller::Artist::wikipedia_extract',
  'Controller::ArtistCredit::base',
  'Controller::ArtistCredit::recording',
  'Controller::ArtistCredit::release',
  'Controller::ArtistCredit::release_group',
  'Controller::ArtistCredit::show',
  'Controller::ArtistCredit::track',
  'Controller::AutoEditorElections::base',
  'Controller::AutoEditorElections::index',
  'Controller::AutoEditorElections::nominate',
  'Controller::AutoEditorElections::show',
  'Controller::CDStub::add',
  'Controller::CDStub::base',
  'Controller::CDStub::browse',
  'Controller::CDStub::show',
  'Controller::CDTOC::base',
  'Controller::CDTOC::show',
  'Controller::Collection::base',
  'Controller::Collection::create',
  'Controller::Collection::edits',
  'Controller::Collection::open_edits',
  'Controller::Collection::show',
  'Controller::Discourse::sso',
  'Controller::Doc::show',
  'Controller::Edit::base',
  'Controller::Edit::edit_type',
  'Controller::Edit::edit_types',
  'Controller::Edit::enter_votes',
  'Controller::Edit::notes_received',
  'Controller::Edit::open',
  'Controller::Edit::search',
  'Controller::Edit::show',
  'Controller::Edit::subscribed',
  'Controller::Edit::subscribed_editors',
  'Controller::Event::alias',
  'Controller::Event::aliases',
  'Controller::Event::annotation_diff',
  'Controller::Event::annotation_history',
  'Controller::Event::annotation_revision',
  'Controller::Event::base',
  'Controller::Event::commons_image',
  'Controller::Event::details',
  'Controller::Event::edits',
  'Controller::Event::latest_annotation',
  'Controller::Event::open_edits',
  'Controller::Event::ratings',
  'Controller::Event::show',
  'Controller::Event::downvote_tags',
  'Controller::Event::upvote_tags',
  'Controller::Event::withdraw_tags',
  'Controller::Event::tags',
  'Controller::Event::wikipedia_extract',
  'Controller::Genre::base',
  'Controller::Genre::details',
  'Controller::Genre::list',
  'Controller::Genre::show',
  'Controller::Instrument::alias',
  'Controller::Instrument::aliases',
  'Controller::Instrument::annotation_diff',
  'Controller::Instrument::annotation_history',
  'Controller::Instrument::annotation_revision',
  'Controller::Instrument::base',
  'Controller::Instrument::commons_image',
  'Controller::Instrument::details',
  'Controller::Instrument::edits',
  'Controller::Instrument::latest_annotation',
  'Controller::Instrument::list',
  'Controller::Instrument::open_edits',
  'Controller::Instrument::show',
  'Controller::Instrument::downvote_tags',
  'Controller::Instrument::upvote_tags',
  'Controller::Instrument::withdraw_tags',
  'Controller::Instrument::tags',
  'Controller::Instrument::wikipedia_extract',
  'Controller::ISRC::_load',
  'Controller::ISRC::base',
  'Controller::ISRC::show',
  'Controller::ISWC::_load',
  'Controller::ISWC::base',
  'Controller::ISWC::show',
  'Controller::Label::alias',
  'Controller::Label::aliases',
  'Controller::Label::annotation_diff',
  'Controller::Label::annotation_history',
  'Controller::Label::annotation_revision',
  'Controller::Label::base',
  'Controller::Label::commons_image',
  'Controller::Label::details',
  'Controller::Label::edits',
  'Controller::Label::latest_annotation',
  'Controller::Label::open_edits',
  'Controller::Label::ratings',
  'Controller::Label::relationships',
  'Controller::Label::show',
  'Controller::Label::downvote_tags',
  'Controller::Label::upvote_tags',
  'Controller::Label::withdraw_tags',
  'Controller::Label::tags',
  'Controller::Label::wikipedia_extract',
  'Controller::MBID::base',
  'Controller::MBID::show',
  'Controller::OAuth2::authorize',
  'Controller::OAuth2::oob',
  'Controller::OAuth2::revoke',
  'Controller::OAuth2::token',
  'Controller::OAuth2::tokeninfo',
  'Controller::OAuth2::userinfo',
  'Controller::OtherLookup::artist-ipi',
  'Controller::OtherLookup::artist-isni',
  'Controller::OtherLookup::barcode',
  'Controller::OtherLookup::catno',
  'Controller::OtherLookup::discid',
  'Controller::OtherLookup::freedbid',
  'Controller::OtherLookup::index',
  'Controller::OtherLookup::isrc',
  'Controller::OtherLookup::iswc',
  'Controller::OtherLookup::label-ipi',
  'Controller::OtherLookup::label-isni',
  'Controller::OtherLookup::mbid',
  'Controller::OtherLookup::url',
  'Controller::Partners::amazon',
  'Controller::Place::alias',
  'Controller::Place::aliases',
  'Controller::Place::annotation_diff',
  'Controller::Place::annotation_history',
  'Controller::Place::annotation_revision',
  'Controller::Place::base',
  'Controller::Place::commons_image',
  'Controller::Place::details',
  'Controller::Place::edits',
  'Controller::Place::latest_annotation',
  'Controller::Place::open_edits',
  'Controller::Place::ratings',
  'Controller::Place::show',
  'Controller::Place::downvote_tags',
  'Controller::Place::upvote_tags',
  'Controller::Place::withdraw_tags',
  'Controller::Place::tags',
  'Controller::Place::wikipedia_extract',
  'Controller::Rating::rate',
  'Controller::Recording::alias',
  'Controller::Recording::aliases',
  'Controller::Recording::annotation_diff',
  'Controller::Recording::annotation_history',
  'Controller::Recording::annotation_revision',
  'Controller::Recording::base',
  'Controller::Recording::details',
  'Controller::Recording::edits',
  'Controller::Recording::fingerprints',
  'Controller::Recording::latest_annotation',
  'Controller::Recording::open_edits',
  'Controller::Recording::ratings',
  'Controller::Recording::show',
  'Controller::Recording::downvote_tags',
  'Controller::Recording::upvote_tags',
  'Controller::Recording::withdraw_tags',
  'Controller::Recording::tags',
  'Controller::Relationship::LinkAttributeType::base',
  'Controller::Relationship::LinkAttributeType::create',
  'Controller::Relationship::LinkAttributeType::list',
  'Controller::Relationship::LinkAttributeType::show',
  'Controller::Relationship::LinkType::base',
  'Controller::Relationship::LinkType::create',
  'Controller::Relationship::LinkType::list',
  'Controller::Relationship::LinkType::show',
  'Controller::Relationship::LinkType::tree',
  'Controller::Relationship::LinkType::type_specific',
  'Controller::Release::alias',
  'Controller::Release::aliases',
  'Controller::Release::annotation_diff',
  'Controller::Release::annotation_history',
  'Controller::Release::annotation_revision',
  'Controller::Release::base',
  'Controller::Release::cover_art',
  'Controller::Release::cover_art_uploaded',
  'Controller::Release::details',
  'Controller::Release::edits',
  'Controller::Release::latest_annotation',
  'Controller::Release::open_edits',
  'Controller::Release::show',
  'Controller::Release::downvote_tags',
  'Controller::Release::upvote_tags',
  'Controller::Release::withdraw_tags',
  'Controller::Release::tags',
  'Controller::ReleaseGroup::alias',
  'Controller::ReleaseGroup::aliases',
  'Controller::ReleaseGroup::annotation_diff',
  'Controller::ReleaseGroup::annotation_history',
  'Controller::ReleaseGroup::annotation_revision',
  'Controller::ReleaseGroup::base',
  'Controller::ReleaseGroup::details',
  'Controller::ReleaseGroup::edits',
  'Controller::ReleaseGroup::forward_merge',
  'Controller::ReleaseGroup::latest_annotation',
  'Controller::ReleaseGroup::open_edits',
  'Controller::ReleaseGroup::ratings',
  'Controller::ReleaseGroup::show',
  'Controller::ReleaseGroup::downvote_tags',
  'Controller::ReleaseGroup::upvote_tags',
  'Controller::ReleaseGroup::withdraw_tags',
  'Controller::ReleaseGroup::tags',
  'Controller::ReleaseGroup::wikipedia_extract',
  'Controller::Report::index',
  'Controller::Report::show',
  'Controller::Root::default',
  'Controller::Root::die_die_die',
  'Controller::Root::index',
  'Controller::Root::set_beta_preference',
  'Controller::Root::set_language',
  'Controller::Search::search',
  'Controller::Series::alias',
  'Controller::Series::aliases',
  'Controller::Series::annotation_diff',
  'Controller::Series::annotation_history',
  'Controller::Series::annotation_revision',
  'Controller::Series::base',
  'Controller::Series::commons_image',
  'Controller::Series::details',
  'Controller::Series::edits',
  'Controller::Series::latest_annotation',
  'Controller::Series::open_edits',
  'Controller::Series::show',
  'Controller::Series::downvote_tags',
  'Controller::Series::upvote_tags',
  'Controller::Series::withdraw_tags',
  'Controller::Series::tags',
  'Controller::Series::wikipedia_extract',
  'Controller::Statistics::countries',
  'Controller::Statistics::coverart',
  'Controller::Statistics::dataset',
  'Controller::Statistics::editors',
  'Controller::Statistics::edits',
  'Controller::Statistics::formats',
  'Controller::Statistics::individual_timeline',
  'Controller::Statistics::languages_scripts',
  'Controller::Statistics::relationships',
  'Controller::Statistics::statistics',
  'Controller::Statistics::timeline',
  'Controller::Statistics::timeline_redirect',
  'Controller::Statistics::timeline_type_data',
  'Controller::Tag::base',
  'Controller::Tag::cloud',
  'Controller::Tag::area',
  'Controller::Tag::artist',
  'Controller::Tag::event',
  'Controller::Tag::instrument',
  'Controller::Tag::label',
  'Controller::Tag::no_tag_provided',
  'Controller::Tag::place',
  'Controller::Tag::recording',
  'Controller::Tag::release',
  'Controller::Tag::release_group',
  'Controller::Tag::series',
  'Controller::Tag::show',
  'Controller::Tag::work',
  'Controller::TagLookup::index',
  'Controller::Test::accept_edit',
  'Controller::Test::reject_edit',
  'Controller::Track::base',
  'Controller::Track::show',
  'Controller::URL::base',
  'Controller::URL::edits',
  'Controller::URL::open_edits',
  'Controller::URL::show',
  'Controller::User::Edits::accepted',
  'Controller::User::Edits::all',
  'Controller::User::Edits::applied',
  'Controller::User::Edits::autoedits',
  'Controller::User::Edits::cancelled',
  'Controller::User::Edits::failed',
  'Controller::User::Edits::open',
  'Controller::User::Edits::rejected',
  'Controller::User::Edits::votes',
  'Controller::User::area_tag',
  'Controller::User::artist_tag',
  'Controller::User::base',
  'Controller::User::collections',
  'Controller::User::event_tag',
  'Controller::User::instrument_tag',
  'Controller::User::label_tag',
  'Controller::User::load_tag',
  'Controller::User::login',
  'Controller::User::logout',
  'Controller::User::place_tag',
  'Controller::User::privileged',
  'Controller::User::profile',
  'Controller::User::rating_summary',
  'Controller::User::ratings',
  'Controller::User::recording_tag',
  'Controller::User::release_group_tag',
  'Controller::User::release_tag',
  'Controller::User::series_tag',
  'Controller::User::tag',
  'Controller::User::tags',
  'Controller::User::work_tag',
  'Controller::Vote::index',
  'Controller::ws1_gone',
  'Controller::WS::2::default',
  'Controller::WS::2::Annotation::annotation_search',
  'Controller::WS::2::Annotation::base',
  'Controller::WS::2::Area::area_search',
  'Controller::WS::2::Area::base',
  'Controller::WS::2::Artist::artist_search',
  'Controller::WS::2::Artist::base',
  'Controller::WS::2::CDStub::cdstub_search',
  'Controller::WS::2::Collection::areas',
  'Controller::WS::2::Collection::areas_get',
  'Controller::WS::2::Collection::artists',
  'Controller::WS::2::Collection::artists_get',
  'Controller::WS::2::Collection::base',
  'Controller::WS::2::Collection::collection_list',
  'Controller::WS::2::Collection::events',
  'Controller::WS::2::Collection::events_get',
  'Controller::WS::2::Collection::instruments',
  'Controller::WS::2::Collection::instruments_get',
  'Controller::WS::2::Collection::labels',
  'Controller::WS::2::Collection::labels_get',
  'Controller::WS::2::Collection::places',
  'Controller::WS::2::Collection::places_get',
  'Controller::WS::2::Collection::recordings',
  'Controller::WS::2::Collection::recordings_get',
  'Controller::WS::2::Collection::release_groups',
  'Controller::WS::2::Collection::release_groups_get',
  'Controller::WS::2::Collection::releases',
  'Controller::WS::2::Collection::releases_get',
  'Controller::WS::2::Collection::series',
  'Controller::WS::2::Collection::series_get',
  'Controller::WS::2::Collection::works',
  'Controller::WS::2::Collection::works_get',
  'Controller::WS::2::DiscID::discid',
  'Controller::WS::2::Event::base',
  'Controller::WS::2::Event::event_search',
  'Controller::WS::2::Genre::base',
  'Controller::WS::2::Genre::genre_search',
  'Controller::WS::2::Instrument::base',
  'Controller::WS::2::Instrument::instrument_search',
  'Controller::WS::2::ISRC::isrc',
  'Controller::WS::2::ISWC::iswc',
  'Controller::WS::2::Label::base',
  'Controller::WS::2::Label::label_search',
  'Controller::WS::2::Place::base',
  'Controller::WS::2::Place::place_search',
  'Controller::WS::2::Rating::rating_lookup',
  'Controller::WS::2::Recording::base',
  'Controller::WS::2::Recording::recording_search',
  'Controller::WS::2::Release::base',
  'Controller::WS::2::Release::release_search',
  'Controller::WS::2::ReleaseGroup::base',
  'Controller::WS::2::ReleaseGroup::release_group_search',
  'Controller::WS::2::Series::base',
  'Controller::WS::2::Series::series_search',
  'Controller::WS::2::Tag::tag_search',
  'Controller::WS::2::URL::base',
  'Controller::WS::2::URL::url_search',
  'Controller::WS::2::Work::base',
  'Controller::WS::2::Work::work_search',
  'Controller::WS::js::Area::search',
  'Controller::WS::js::Artist::search',
  'Controller::WS::js::CheckDuplicates::check_duplicates',
  'Controller::WS::js::Editor::search',
  'Controller::WS::js::Event::search',
  'Controller::WS::js::Genre::search',
  'Controller::WS::js::Instrument::search',
  'Controller::WS::js::Label::search',
  'Controller::WS::js::Place::search',
  'Controller::WS::js::Recording::search',
  'Controller::WS::js::Release::release',
  'Controller::WS::js::Release::search',
  'Controller::WS::js::ReleaseGroup::search',
  'Controller::WS::js::Series::search',
  'Controller::WS::js::Work::search',
  'Controller::WS::js::cdstub',
  'Controller::WS::js::cdstub_search',
  'Controller::WS::js::cover_art_upload',
  'Controller::WS::js::default',
  'Controller::WS::js::entities',
  'Controller::WS::js::entity',
  'Controller::WS::js::events',
  'Controller::WS::js::medium',
  'Controller::WS::js::medium_search',
  'Controller::WS::js::ParseCoordinates::parse_coordinates',
  'Controller::WS::js::tracks',
  'Controller::Watch::list',
  'Controller::Work::alias',
  'Controller::Work::aliases',
  'Controller::Work::annotation_diff',
  'Controller::Work::annotation_history',
  'Controller::Work::annotation_revision',
  'Controller::Work::base',
  'Controller::Work::commons_image',
  'Controller::Work::details',
  'Controller::Work::edits',
  'Controller::Work::latest_annotation',
  'Controller::Work::open_edits',
  'Controller::Work::ratings',
  'Controller::Work::show',
  'Controller::Work::downvote_tags',
  'Controller::Work::upvote_tags',
  'Controller::Work::withdraw_tags',
  'Controller::Work::tags',
  'Controller::Work::wikipedia_extract',
  'ControllerBase::WS::2::root',
  'ControllerBase::WS::js::root',
  'ControllerBase::WS::js::root',
);


1;
