/*
 * @flow strict-local
 * Copyright (C) 2018 MetaBrainz Foundation
 *
 * This file is part of MusicBrainz, the open internet music database,
 * and is licensed under the GPL version 2, or (at your option) any
 * later version: http://www.gnu.org/licenses/gpl-2.0.txt
 */

import * as React from 'react';

import RecordingList from './components/RecordingList';
import ReportLayout from './components/ReportLayout';
import type {ReportDataT, ReportRecordingT} from './types';

const RecordingsWithoutVaCredit = ({
  $c,
  canBeFiltered,
  filtered,
  generated,
  items,
  pager,
}: ReportDataT<ReportRecordingT>): React.Element<typeof ReportLayout> => (
  <ReportLayout
    $c={$c}
    canBeFiltered={canBeFiltered}
    description={l(
      `This report shows recordings linked to the Various Artists entity
       without "Various Artists" as the credited name.`,
    )}
    entityType="recording"
    filtered={filtered}
    generated={generated}
    title={l('Recordings not credited to "Various Artists" but linked to VA')}
    totalEntries={pager.total_entries}
  >
    <RecordingList items={items} pager={pager} />
  </ReportLayout>
);

export default RecordingsWithoutVaCredit;
